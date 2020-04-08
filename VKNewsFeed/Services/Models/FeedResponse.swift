//
//  FeedResponse.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 3/31/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    let items: [FeedItem]
    let profiles: [Profile]
    let groups: [Group]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let posd: String?
    let date: Double
    let text: String?
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachment]?
}

struct Attachment: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    
    var width: Int {
        getPhotoSize().width
    }
    
    var height: Int {
        getPhotoSize().height
    }
    
    var imageUrl: String {
        getPhotoSize().url
    }
    
    private func getPhotoSize() -> PhotoSize  {
        if let sizeX = sizes.first(where: { $0.type == "x" }) {
            return sizeX
        } else if let sizeZ = sizes.last(where: { $0.type == "y" }) {
            return sizeZ
        } else {
            return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
        }
    }
}

struct PhotoSize: Decodable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

struct CountableItem: Decodable {
    let count: Int
}

protocol Representable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

struct Profile: Decodable, Representable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String { return firstName + " " + lastName }
    var photo: String { return photo100 }
}

struct Group: Decodable, Representable {
    let id: Int
    let name: String
    let photo100: String
    
    var photo: String { return photo100 }
}
