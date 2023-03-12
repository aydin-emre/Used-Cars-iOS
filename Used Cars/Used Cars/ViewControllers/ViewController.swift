//
//  ViewController.swift
//  Used Cars
//
//  Created by Emre on 12.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    private var reposViewModel = CarViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBindings()
        reposViewModel.getCars()
    }

    func setupBindings() {
        // Error Handling
        reposViewModel
            .error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                guard let self = `self` else { return }
                self.alert.setMessage(error)
                self.alert.show()
            })
            .disposed(by: disposeBag)

        // Cars TableView
        reposViewModel
            .cars
            .observe(on: MainScheduler.instance)
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "CarTableViewCell", cellType: CarTableViewCell.self)) { _, car, cell in
                    cell.configure(with: car)
                }
                .disposed(by: disposeBag)
    }

}
