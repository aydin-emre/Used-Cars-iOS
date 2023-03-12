//
//  Car.swift
//  Used Cars
//
//  Created by Emre on 12.03.2023.
//

import Foundation

typealias CarResponse = [Car]

struct Car: Decodable {
    let id: Int?
    let make: String?
    let model: String?
    let price: Int?
    let firstRegistration: String?
    let mileage: Int?
    let fuel: String?
    let images: [Image]?
    let description: String?
    let modelline: String?
    let seller: Seller?
    let colour: String?
}

struct Image: Decodable {
    let url: String?
}

struct Seller: Decodable {
    let type, phone, city: String?
}
