//
//  NewsFeedLayoutCalculator.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/4/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit


struct FeedSizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCelllayoutCalculator: FeedCellLayoutCalculatorProtocol {

    // MARK: - Private properties
    private var screenWidth: CGFloat
    
    
    // MARK: - Init
    init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
        self.screenWidth = screenWidth
    }
    
    // MARK: - FeedCellLayoutCalculatorProtocol
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        return FeedSizes(postLabelFrame: CGRect.zero, attachmentFrame: CGRect.zero)
    }
    
}
 
