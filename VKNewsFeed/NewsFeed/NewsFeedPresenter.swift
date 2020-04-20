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
        case .presentNewsFeed(let feed, let revealedPostIds):
            
            print(revealedPostIds)
            
            let feedCells = feed.items.map { feedItem  in
                cellViewModel(feedItem: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealedPostIds)
            }
            
            let footerTitle = String.localizedStringWithFormat(NSLocalizedString("news feed cells count", comment: ""), feedCells.count)
            
            let feedViewModel = FeedViewModel(cells: feedCells, footerTirle: footerTitle)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
            
        case .presentUserInfo(user: let user):
            let user = UserViewModel(photoUrlString: user.photo100)
            viewController?.displayData(viewModel: .displayUser(userViewModel: user))
            
        case .presentFooterLoader:
            viewController?.displayData(viewModel: .displayFoterLoader)
        }
    }
    
    
    // MARK: - Private methods
    private func cellViewModel(feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(sourceId: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateItem = dateFormatter.string(from: date)
        
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        
        let isFullSized = revealedPostIds.contains { $0 == feedItem.postId }
        
        let sizes = layoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSized: isFullSized)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        return FeedViewModel.Cell(postId: feedItem.postId,
                                  iconUrlString: profile.photo,
                                  name: profile.name,
                                  date: dateItem,
                                  text: postText ?? "",
                                  likes: formatedCounter(feedItem.likes?.count),
                                  commets: formatedCounter(feedItem.comments?.count),
                                  shares: formatedCounter(feedItem.reposts?.count),
                                  views: formatedCounter(feedItem.views?.count),
                                  photoAttachments: photoAttachments,
                                  sizes: sizes)
    }
    
    private func formatedCounter(_ counter: Int?) -> String? {
        guard let counter = counter else { return nil }
        var counterString = String(counter)
        
        if counterString.count >= 4 && counterString.count < 6 {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 && counterString.count < 9 {
            counterString = String(counterString.dropLast(6)) + "M"
        } else if counterString.count > 9 {
            counterString = String(counterString.dropLast(9)) + "B"
        }
        
        return counterString
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
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap { attachment in
            guard let photo = attachment.photo else { return nil }
            
            return FeedViewModel.FeedCellPhotoAttachment(postUrlString: photo.imageUrl,
                                                         width: photo.width,
                                                         hieght: photo.height)
        }
    }
}


