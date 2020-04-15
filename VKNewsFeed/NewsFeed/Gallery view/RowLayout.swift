//
//  RowLayout.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/16/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol RowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
    weak var delegate: RowLayoutDelegate!
    
    private var numberOfRows = 1
    private var cellPadding: CGFloat = 8
    private var cache = [UICollectionViewLayoutAttributes]()
    
    // Constants
    private var contentWidth: CGFloat = 0
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        
        return collectionView.bounds.height - (insets.top + insets.bottom)
    }
    
    override var collectionViewContentSize: CGSize { return CGSize(width: contentWidth, height: contentHeight) }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0...collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        let superViewWidth = collectionView.frame.width
        guard let rowHeight = rowHeightCounter(superViewWidth: superViewWidth, photosArray: photos) else { return }
        
        
    }
    
    private func rowHeightCounter(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        
        let photoMinRatio = photosArray.min { first, second in
            (first.height / first.width) < (first.height / first.width)
        }
        
        guard let myPhotoMinRatio = photoMinRatio else { return nil }
        
        let difference = superViewWidth / myPhotoMinRatio.width
        rowHeight = difference * difference
        
        return rowHeight
    }
    
}

// potocol
//attribute - numberOfRows, cellPadding
// cache array for cahing computer attribute, prepare calculate every cell and append in cache
// content width, content hieght
// override content size
// prepare - cacheIsEmpty, collectionView != nil
// calculate collectionView height
