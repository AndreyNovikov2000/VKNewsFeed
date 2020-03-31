//
//  NetworkService.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 3/31/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import Foundation

class NetworkService {
   
    // MARK: - Private properties
    private let authService: AuthService
    
    // MARK: - Init
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    // MARK - Public properties
    func getFeed() {
        
        guard let token = authService.token else { return }
        
        var components = URLComponents()
        
        let methods = ["filters" : "post, photo"]
        var allParams = methods
        allParams["v"] = API.version
        allParams["access_token"] = token
        
        
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.path
        components.queryItems = allParams.map({ URLQueryItem(name: $0, value: $1) })
    }
}

//https://api.vk.com/method/users.get?user_ids=210700286&fields=bdate&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3&v=5.103
