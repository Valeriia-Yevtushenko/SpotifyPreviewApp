//
//  ImageViewExtention.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation
import PromiseKit

class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        image = nil
        
        if let imageFromCache = CacheImageStorage.cache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            
            guard error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data, let imageToCache = UIImage(data: data) else { return }
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                CacheImageStorage.cache.setObject(imageToCache, forKey: NSString(string: urlString))
            }
            
        }).resume()
    }
}
