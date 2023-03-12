//
//  CarTableViewCell.swift
//  Used Cars
//
//  Created by Emre on 12.03.2023.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carView: CarView!

    func configure(with car: Car) {
        carView.setView(with: car)
    }

}
