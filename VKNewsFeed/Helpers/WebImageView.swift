//
//  WebImageView.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/2/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
    
    func set(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        if let caceResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            image = UIImage(data: caceResponse.data)
            return
        }
        
        let sessionDataTask = URLSession.shared.dataTask(with: url) { [weak self ] (data, response, error) in
            if let error = error {
                print("Fail to load image, error = \(error)")
                return
            }
            guard let data = data, let response = response else { return }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
                self?.hendleLoadedImage(data: data, response: response)
            }
        }
        sessionDataTask.resume()
    }
    
    // MARK: - Private
    private func hendleLoadedImage(data: Data, response: URLResponse) {
        guard let responseUrl = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseUrl))
    }
}

