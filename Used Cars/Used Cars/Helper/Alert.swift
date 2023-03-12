//
//  Alert.swift
//  Used Cars
//
//  Created by Emre on 12.03.2023.
//

import UIKit
import EAAlert

class Alert: EAAlert {

    var posButtonText: String?
    override var positiveButtonText: String {
        get {
            return posButtonText ?? "Yes"
        }
        set {
            posButtonText = newValue
        }
    }

    var negButtonText: String?
    override var negativeButtonText: String {
        get {
            return negButtonText ?? "No"
        }
        set {
            negButtonText = newValue
        }
    }

}
