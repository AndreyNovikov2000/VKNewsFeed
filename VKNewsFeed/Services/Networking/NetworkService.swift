//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 3/31/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], complition: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    // MARK: - Private properties
    private let authService: AuthService
    
    
    // MARK: - Init
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    
    // MARK - Public properties
    func request(path: String, params: [String : String], complition: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        
        guard let url = self.url(from: path, params: allParams) else { return }
        
        let request = URLRequest(url: url)
        let task = setupDataTask(from: request, complition: complition)
        task.resume()
    }
    
    
    // MARK: Private methods
    private func setupDataTask(from request: URLRequest, complition: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                complition(data, error)
            }
        }
    }
    
    private func url(from path: String, params: [String: String]) -> URL? {
        var components = URLComponents()
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url
    }
}

