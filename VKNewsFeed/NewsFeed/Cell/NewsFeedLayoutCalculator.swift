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
    var bottomviewFrame: CGRect
    var moreTextButtonFrame: CGRect
    var totalHieght: CGFloat
}


protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FeedCellSizes
}

final class FeedCelllayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    // MARK: - Private properties
    private var screenWidth: CGFloat
    
    
    // MARK: - Init
    init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
        self.screenWidth = screenWidth
    }
    
    // MARK: - FeedCellLayoutCalculatorProtocol
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: - Work with post label frame
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(labelWidth: width, font: Constants.postLabelFont)
            
            
            
            // Post lines height
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if height > limitHeight && !isFullSized {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
            
        }
        
        // MARK: - Work with more text button frame
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = CGSize(width: Constants.moreTextButtonSize.width,
                                        height: Constants.moreTextButtonSize.height)
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left,
                                           y: postLabelFrame.maxY)
        let moretextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        
        // MARK: - Work with attachment frame
        let attachmentOriginY = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moretextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0,y: attachmentOriginY),
                                     size: CGSize.zero)
        
        
        if let attachment = photoAttachments.first {
            let ratio = CGFloat(attachment.hieght) / CGFloat(attachment.width)
            let height = cardViewWidth * ratio
            
            if photoAttachments.count == 1 {
                let attachmentSize = CGSize(width: cardViewWidth, height: height)
                attachmentFrame.size = attachmentSize
            } else if photoAttachments.count > 1 {
                let attachmentSize = CGSize(width: cardViewWidth, height: height)
                attachmentFrame.size = attachmentSize
            }
        }
        
        
        // MARK: - Work with bottom frame
        let bottomViewOriginY = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewOriginY),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHieght))
        
        // MARK: - Total hieght
        let totalHieght = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return FeedSizes(postLabelFrame: postLabelFrame,
                         attachmentFrame: attachmentFrame,
                         bottomviewFrame: bottomViewFrame,
                         moreTextButtonFrame: moretextButtonFrame,
                         totalHieght: totalHieght)
    }
    
}

