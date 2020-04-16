//
//  NetworkDataFetcher.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 3/31/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void) 
}

struct NetworkDataFetcher: DataFetcher {
    
    // MARK: - Private properties
    private let networking: Networking = NetworkService()
    private let authService = AppDelegate.shared().authService
    
    // MARK: - Public methods
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        
        networking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
                return
            }
            
            guard let data = data else { return }
            let newsFeed = self.decodeJson(type: FeedResponseWrapped.self, from: data)
            response(newsFeed?.response)
        }
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService?.userId else { return }
        
        let params = ["fields": "photo_100", "user_ids": "\(userId)"]
        
        networking.request(path: API.user, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
                return
            }
            
            guard let data = data else { return }
            let user = self.decodeJson(type: UserResponseWrapped.self, from: data)
            response(user?.response.first)
        }
    }
    
    
    // MARK: - Private methods
    private func decodeJson<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        guard let data = data else { return nil }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let object = try? decoder.decode(type.self, from: data)
        return object
    }
}
