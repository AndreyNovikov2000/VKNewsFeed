//
//  String + Height.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/5/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func height(labelWidth: CGFloat, font: UIFont) -> CGFloat {
        let labelSize = CGSize(width: labelWidth, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: labelSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        
        return ceil(size.height)
    }
}
