//
//  CarViewModel.swift
//  Used Cars
//
//  Created by Emre on 12.03.2023.
//

import Foundation
import RxSwift
import RxCocoa

class CarViewModel {

    public let cars: PublishSubject<CarResponse> = PublishSubject()
    public let error: PublishSubject<String> = PublishSubject()

    public func getCars() {
        NetworkManager.shared.getCars { result in
            switch result {
            case .success(let response):
                self.cars.onNext(response)
            case .failure(let error):
                self.error.onNext(error.localizedDescription)
            }
        }
    }

}
