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
    
    let layoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCelllayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM в HH:mm"
        return dateFormatter
    }()
    
    // MARK: - Public properties
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
        case .presentNewsFeed(let feed):
            
            let feedCells = feed.items.map { feedItem  in
                cellViewModel(feedItem: feedItem, profiles: feed.profiles, groups: feed.groups)
            }
            
            let feedViewModel = FeedViewModel(cells: feedCells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    
    // MARK: - Private methods
    private func cellViewModel(feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        
        let profile = self.profile(sourceId: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateItem = dateFormatter.string(from: date)
        
        let photoAttachment = self.photoAttachment(feedItem: feedItem)
        
        let sizes = layoutCalculator.sizes(postText: feedItem.text, photoAttachment: photoAttachment)
        
        return FeedViewModel.Cell(iconUrlString: profile.photo,
                                  name: profile.name,
                                  date: dateItem,
                                  text: feedItem.text ?? "",
                                  likes: String(feedItem.likes?.count ?? 0),
                                  commets: String(feedItem.comments?.count ?? 0),
                                  shares: String(feedItem.reposts?.count ?? 0),
                                  views: String(feedItem.views?.count ?? 0),
                                  photoAttachment: photoAttachment,
                                  sizes: sizes)
    }
    
    
    private func profile(sourceId: Int, profiles: [Profile], groups: [Group]) -> Representable {
        
        let profilesOrGroups: [Representable] = sourceId >= 0 ? profiles : groups
        let realSourseId = sourceId >= 0 ? sourceId : -sourceId
        let representable = profilesOrGroups.first { representableItem in
            representableItem.id == realSourseId
        }
        return representable!
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment?  {
        
        guard let photos = feedItem.attachments?.compactMap({ attachmentPhotos in
            attachmentPhotos.photo
        }), let firstPhoto = photos.first else {
                return nil
        }
        
        return FeedViewModel.FeedCellPhotoAttachment(postUrlString: firstPhoto.imageUrl,
                                                     width: firstPhoto.width,
                                                     hieght: firstPhoto.height)
    }
}

