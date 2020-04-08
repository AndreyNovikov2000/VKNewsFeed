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
    
    // MARK: Private properties
    private let networkFetcher: DataFetcher = NetworkDataFetcher()
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    
    
    // MARK: - NewsFeedBusinessLogic
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
        case .getFeed:
            networkFetcher.getFeed { [weak self] feedResponse in
                self?.feedResponse = feedResponse
                self?.presenrFeed()
            }
            
        case .revealWithPostIDs(let id):
            revealedPostIds.append(id)
            presenrFeed()
        }
    }
    
    
    // MARK: Private func
    private func presenrFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealedPostIds: revealedPostIds))
    }
    
}
