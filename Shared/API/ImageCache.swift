//
//  ImageCache.swift
//  Qapital Activities UIKit
//
//  Created by Konstantin Zyrianov on 2021-09-16.
//

import UIKit

final class ImageCache {
    private init() {}
    
    static let shared: ImageCache = ImageCache()
    
    private let cache: NSCache<NSString, UIImage> = NSCache()
    
    func cache(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: NSString(string: url))
    }
    
    func image(for url: String) -> UIImage? {
        return cache.object(forKey: NSString(string: url))
    }
}
