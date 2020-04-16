//
//  UserResponse.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/17/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
