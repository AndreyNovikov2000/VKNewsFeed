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
        case revealWithPostIDs(id: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse, revealedPostIds: [Int])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
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
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
        var sizes: FeedCellSizes
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var postUrlString: String?
        var width: Int
        var hieght: Int
    }
    
    let cells: [Cell]
}
