//
//  ImageLoader.swift
//  InstagramClone
//
//  Created by Wataru Uehara on 2026/05/03.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private init(){}
    
    private let cache = NSCache<NSURL, UIImage>()
    
    func loadImage(urlString: String) async -> UIImage? {
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            cache.setObject(image, forKey: url as NSURL)
            return image
        } catch {
            return nil
        }
    }
}
