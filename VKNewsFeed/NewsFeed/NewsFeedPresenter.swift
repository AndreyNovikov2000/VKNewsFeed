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
    weak var viewController: NewsFeedDisplayLogic?
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        switch response {
        case .some:
            print(".some presenter")
        case .presentNewsFeed:
            print(".presentNewsFeed presenter")
            viewController?.displayData(viewModel: .displayNewsFeed)
        }
    }
}
