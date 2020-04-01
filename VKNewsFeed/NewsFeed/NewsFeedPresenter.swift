//
//  NewsFeedPresenter.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/1/20.
//  Copyright (c) 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    // MARK: - External properties
    weak var viewController: NewsFeedDisplayLogic?
    
    
    // MARK: - Public properties
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
        case .presentNewsFeed(let feed):
            
            let feedCells = feed.items.map { feedItem in
                cellViewModel(feedItem: feedItem)
            }
            
            let feedViewModel = FeedViewModel(cells: feedCells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    
    // MARK: - Private methods
    private func cellViewModel(feedItem: FeedItem) -> FeedViewModel.Cell {
        return FeedViewModel.Cell(iconUrlString: "future icon",
                                  name: "future name",
                                  date: "future date",
                                  text: feedItem.text ?? "",
                                  likes: String(feedItem.likes?.count ?? 0),
                                  commets: String(feedItem.comments?.count ?? 0),
                                  shares: String(feedItem.reposts?.count ?? 0),
                                  views: String(feedItem.views?.count ?? 0))
    }
}
