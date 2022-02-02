//
//  ImageViewExtention.swift
//  MusicApp
//
//  Created by Yevtushenko Valeriia on 28.05.2021.
//

import Foundation
import PromiseKit

extension UIImageView {
    
    private func fetch(withUrl urlString: String) {
        firstly {
            fetchImageData(withUrl: urlString)
        }.done { image, url in
            self.image = image
            CacheImageStorage.cache.setObject(image!, forKey: NSString(string: url))
        }.catch {_ in}
    }
    
    func setImage(withUrl urlString: String) {
        let key = NSString(string: urlString)
        
        guard let cachedImage = CacheImageStorage.cache.object(forKey: key) else {
            fetch(withUrl: urlString)
            return
        }
        
        self.image = cachedImage
    }
    
    private func fetchImageData(withUrl urlString: String) -> Promise<(UIImage?, String)> {
        return Promise { seal in
            DispatchQueue.global(qos: .userInteractive).async {
                guard let url = URL(string: urlString),
                      let imageData = NSData(contentsOf: url),
                      let image = UIImage(data: imageData as Data) else {
                    seal.resolve(.fulfilled((UIImage(named: "default"), urlString)))
                    return
                }
                
                seal.resolve(.fulfilled((image, urlString)))
            }
        }
    }
}
