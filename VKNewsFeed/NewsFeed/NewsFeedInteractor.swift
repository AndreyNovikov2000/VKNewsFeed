//
//  NewsFeedInteractor.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/1/20.
//  Copyright (c) 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    // MARK: - External properties
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    
    // MARK: - NewsFeedBusinessLogic
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
      
        switch request {
        case .getFeed:
            service?.getFeed(complition: { [weak self] (revealedPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
            
        case .getUser:
            service?.getUser(complition: { [weak self] user in
                self?.presenter?.presentData(response: .presentUserInfo(user: user))
            })
            
        case .revealWithPostIDs(id: let id):
            service?.revealedPostIds(postId: id, complition: { [weak self] (revealedPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        case .getNextBatch:
            service?.getNextBatch(complition: { [weak self] (revealedPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        }
    }
}
