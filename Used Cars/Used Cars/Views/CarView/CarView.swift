//
//  CarView.swift
//  Used Cars
//
//  Created by Emre on 12.03.2023.
//

import UIKit
import Kingfisher

final class CarView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imageCountContainerView: UIView!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var imagePageControl: UIPageControl!

    private var images: [Image]!
    private let imageViewHeight: CGFloat = 223
    private var slideViewWidth: CGFloat!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

    private func setupView() {
        Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        slideViewWidth = self.frame.width
        imageScrollView.delegate = self
    }

    func setView(with car: Car) {
        if let images = car.images {
            self.images = images
            createSlides()
        }
    }

    private func createSlides() {
        imagePageControl.currentPage = 0
        imageScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        var slides = [UIView]()
        imageCountContainerView.isHidden = images.count < 2
        imageCountLabel.text = "1/\(images.count)"
        for image in images {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: slideViewWidth, height: imageViewHeight))
            let processor = DownsamplingImageProcessor(size: imageView.bounds.size)

            imageView.kf.indicatorType = .activity
            imageView.contentMode = .scaleToFill
            imageView.kf.setImage(
                with: URL(string: image.url ?? ""),
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }

            slides.append(imageView)
        }

        setupSlideScrollView(slides: slides)

        imagePageControl.numberOfPages = slides.count
        imagePageControl.currentPage = 0
        bringSubviewToFront(imagePageControl)
    }

    private func setupSlideScrollView(slides: [UIView]) {
        imageScrollView.frame = CGRect(x: 0, y: 0, width: slideViewWidth, height: imageViewHeight)
        imageScrollView.contentSize = CGSize(width: slideViewWidth * CGFloat(slides.count), height: imageViewHeight)
        imageScrollView.isPagingEnabled = true
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.bounces = false
        imageScrollView.contentSize.height = 1.0

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: (slideViewWidth * CGFloat(i)), y: 0, width: slideViewWidth, height: imageViewHeight)
            imageScrollView.addSubview(slides[i])
        }
    }

}

extension CarView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(round(scrollView.contentOffset.x/frame.width))
        imagePageControl.currentPage = currentPage
        imageCountLabel.text = "\(currentPage+1)/\(images.count)"
    }

}
