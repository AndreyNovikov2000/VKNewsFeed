//
//  NewsFeedModels.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/1/20.
//  Copyright (c) 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getFeed
        case getUser
        case revealWithPostIDs(id: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse, revealedPostIds: [Int])
        case presentUserInfo(user: UserResponse)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
        case displayUser(userViewModel: TitleViewViewModel)
      }
    }
  }
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        let postId: Int
        
        var iconUrlString: String
        var name: String
        var date: String
        var text: String
        var likes: String?
        var commets: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var postUrlString: String?
        var width: Int
        var hieght: Int
    }
    
    let cells: [Cell]
}

struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}
