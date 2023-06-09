//
//  BaseViewController.swift
//  Used Cars
//
//  Created by Emre on 12.03.2023.
//

import UIKit

public class BaseViewController: UIViewController {

    var alert: Alert!

    public func initialSetup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        alert = Alert()
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
