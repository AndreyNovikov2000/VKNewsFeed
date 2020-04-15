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
    
    // MARK: - External properties
    weak var delegate: RowLayoutDelegate!
    static var numberOfRows = 2
    
    // MARK: Private properties
    private var cellPadding: CGFloat = 8
    private var cache = [UICollectionViewLayoutAttributes]()
    
    // Constants
    private var contentWidth: CGFloat = 0
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    
    override var collectionViewContentSize: CGSize { return CGSize(width: contentWidth, height: contentHeight) }
    
    override func prepare() {
        
        // FIX: - CollectionView reused in tableView cell
        contentWidth = 0
        cache = []
        
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath) 
                photos.append(photoSize)
        }
        
        // Row hieght
        let superViewWidth = collectionView.frame.width
        guard var rowHeight = RowLayout.rowHeightCounter(superViewWidth: superViewWidth, photosArray: photos) else { return }
        rowHeight = rowHeight / CGFloat(RowLayout.numberOfRows)
        
        // photos ratio
        let photosRations = photos.map { $0.height / $0.width}
        
        // yOffSet
        var yOffSet = [CGFloat]()
        
        for row in 0..<RowLayout.numberOfRows {
            let offSet = CGFloat(row) * rowHeight
            yOffSet.append(offSet)
        }
        
        // xOffSet
        var xOffSet = [CGFloat](repeating: 0, count: RowLayout.numberOfRows)
        
        var row = 0
        
        // frame and cache
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            let ration = photosRations[indexPath.row]
            let width = rowHeight / ration
            let frame = CGRect(x: xOffSet[row], y: yOffSet[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentWidth = max(contentWidth, frame.maxX)
            xOffSet[row] = xOffSet[row] + width
            
            row = row < (RowLayout.numberOfRows - 1) ? row + 1 : 0
        }
        
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        
        return visibleLayoutAttributes
    }


    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    
    // MARK: - Private properties
    static func rowHeightCounter(superViewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        
        let photoMinRatio = photosArray.min { first, second in
            (first.height / first.width) < (first.height / first.width)
        }
        
        guard let myPhotoMinRatio = photoMinRatio else { return nil }
        
        let difference = superViewWidth / myPhotoMinRatio.width
        rowHeight = myPhotoMinRatio.height * difference
        
        rowHeight = rowHeight * CGFloat(RowLayout.numberOfRows)
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
// yOffSet, xOffSet
// image width
// frame current image from yOffSet and xOffSet
// set UIcollectioViewAttributes
// layoutAttributesForElements in, all [UIcollestioViewAttributes] in visible content
// layoutAttributesForElements at, UIcollectioViewAttributes for current cell
// collectionViewLayout sub delegate

