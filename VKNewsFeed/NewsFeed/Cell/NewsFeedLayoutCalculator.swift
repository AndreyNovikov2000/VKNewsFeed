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
    var bottomView: CGRect
    var totalHieght: CGFloat
}

struct Constants {
    static let topViewHieght: CGFloat = 40
    static let postLabelFont = UIFont.systemFont(ofSize: 16)
    
    static let cardInsets = UIEdgeInsets(top: 0,
                                         left: 8,
                                         bottom: 8,
                                         right: 11)
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHieght + 8,
                                              left: 8,
                                              bottom: 8,
                                              right: 8)
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
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: - Work with post label frame
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(labelWidth: width, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        return FeedSizes(postLabelFrame: postLabelFrame,
                         attachmentFrame: CGRect.zero,
                         bottomView: CGRect.zero,
                         totalHieght: 300)
    }
    
}
 
