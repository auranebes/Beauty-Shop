//
//  DataManager.swift
//  Beuty Shop
//
//  Created by Arslan Abdullaev on 22.01.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    let productsURL = [
        "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=blush",
        "http://makeup-api.herokuapp.com/api/v1/products.json?product_tags=Natural&product_type=lipstick"
    ]
    let productsName = [
        "Eyeshadows", "Lipsticks"
    ]
    
    private init() {}
}
