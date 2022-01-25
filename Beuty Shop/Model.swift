//
//  Model.swift
//  Beuty Shop
//
//  Created by Arslan Abdullaev on 22.01.2022.
//

import Foundation
import Alamofire

struct Cosmetic: Codable {
        let id: Int?
        let brand: String?
        let name: String?
        let price: String?
        let price_sign: String?
        let currency: String?
        let image_link: String?
        let product_link: String?
        let website_link: String?
        let description: String?
      
        let category: String?
        let product_type: String?
        let tag_list: [String]?
        let created_at: String?
        let updated_at: String?
        let product_api_url: String?
        let api_featured_image: String?
        let product_colors: [ProductColors]?
    }

struct ProductColors: Codable {
    let hex_value: String?
    let colour_name: String?
}

struct User: Codable {
    var phoneNumber: String?
    var nickName: String?
    var email: String?
    var firstName: String?
}

struct UserActions {
    let productsName: String
    let producrtsURL: String
    
    static func getCategoriesInfo() -> [UserActions] {
        
        var categories: [UserActions] = []
        
        let names = DataManager.shared.productsName
        let URLs = DataManager.shared.productsURL
        
        let iterationCount = min(
            names.count,
            URLs.count
        )
        
        for index in 0..<iterationCount {
            let category = ( UserActions(productsName: names[index],
                                         producrtsURL: URLs[index])
            )
            
            categories.append(category)
        }
        
        return categories
    }
}

