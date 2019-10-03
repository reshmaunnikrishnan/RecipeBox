//
//  UIImageView+Download.swift
//  RecipeBox
//
//  Extension to allow downnload/cache of image from URL
//
//  Created by Reshma Unnikrishnan on 29.06.19.
//  Copyright © 2019 ruvlmoon. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // MARK: - Public methods
    
    /// Download image from url
    ///
    /// - Parameters
    ///     - url: URL of the image
    ///     - placeholder: UIImage to be used as a placeholder
    ///     - cache: URLCache to store the downloaded image
    func downloadImage(from url: URL, placeholder: UIImage, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            getData(from: url) { data, response, error in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    self.image = image
                }
            }
        }
    }
    
    // MARK: - private Methods
    
    /// Get Data from url
    ///
    /// - Parameters
    ///     - url: URL of the image
    ///     - completion: Completion hgandler
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
