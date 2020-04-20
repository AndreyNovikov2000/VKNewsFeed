//
//  NewsFeedWorker.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/1/20.
//  Copyright (c) 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class NewsFeedService {
    
    
    let fetcher: DataFetcher = NetworkDataFetcher()
    
    // MARK: - Private properties
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    
    // MARK: - Get user info
    func getUser(complition: @escaping (UserResponse) -> Void) {
        fetcher.getUser { user in
            
            guard let user = user else { return }
            
            complition(user)
        }
    }
    
    
    // MARK: - Get feed
    func getFeed(complition: @escaping ([Int], FeedResponse) -> Void) {
        fetcher.getFeed(nextBatchFrom: nil) { [weak self] feed in
            
            self?.feedResponse = feed

            guard let feedResponse = self?.feedResponse else { return }
            
            complition(self!.revealedPostIds, feedResponse)
        }
    }
    
    
    // MARK: - revealed post
    func revealedPostIds(postId: Int, complition: @escaping ([Int], FeedResponse) -> Void) {
        revealedPostIds.append(postId)
        guard let feedResponse = feedResponse else { return }
        complition(revealedPostIds, feedResponse)
    }
    
    
    // MARK: - get old posts
    func getNextBatch(complition: @escaping ([Int], FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        
        fetcher.getFeed(nextBatchFrom: newFromInProcess) { [weak self] feed in
            
            guard let feed = feed else { return }
            guard self?.feedResponse?.nextFrom != feed.nextFrom else { return }
            
            if self?.feedResponse == nil {
                self?.feedResponse = feed
            } else {
                self?.feedResponse?.items.append(contentsOf: feed.items)
            }
            
            // new profiles + old profiles
            var profiles = feed.profiles
            var groups = feed.groups
                        
            if let oldProfiles = self?.feedResponse {
                
                // при каждой итерации значение у нас значение будет добавляться в массив oldProfilesFiltred
                // если из всего скиска новых профилей не существует ни одного с тем же id
                // те мы ищем все новых и старых записей, и тех id которых не существует добавляем в массив
                
                let oldProfilesFiltred = oldProfiles.profiles.filter { oldProfile in
                    !feed.groups.contains(where: { $0.id == oldProfile.id })
                }
                
                profiles.append(contentsOf: oldProfilesFiltred)
                self?.feedResponse?.profiles = profiles
            }
            
            if let oldGroups = self?.feedResponse?.groups {
                
                // если новые записи не сожержат id старых то мы их добавляем
                let oldGroupsFiltred = oldGroups.filter { oldGroup in
                    !feed.groups.contains(where: { $0.id == oldGroup.id })
                }
                
                groups.append(contentsOf: oldGroupsFiltred)
                self?.feedResponse?.groups = groups
            }
            
            guard let feedResponse = self?.feedResponse else { return }
            
            complition(self!.revealedPostIds, feedResponse)
        }
    }
}

