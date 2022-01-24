//
//  imageCache.swift
//  Beuty Shop
//
//  Created by Arslan Abdullaev on 25.01.2022.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}

