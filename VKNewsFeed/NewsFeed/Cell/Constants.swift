//
//  Constants.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/6/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

struct Constants {
    static let topViewHieght: CGFloat = 40
    static let bottomViewHieght: CGFloat = 50
    static let bottomViewWidth: CGFloat = 80
    static let bottomViewViewsIconSize: CGFloat = 24
    static let postLabelFont = UIFont.systemFont(ofSize: 16)
    
    static let cardInsets = UIEdgeInsets(top: 0,
                                         left: 8,
                                         bottom: 11,
                                         right: 8)
    
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHieght + 8,
                                              left: 8,
                                              bottom: 8,
                                              right: 8)
    
    static let imageViewInsets = UIEdgeInsets(top: 8 + Constants.topViewHieght + 8,
                                              left: 0,
                                              bottom: 8,
                                              right: 0)
}
