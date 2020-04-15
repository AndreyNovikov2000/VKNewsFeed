//
//  GalleryCollectionView.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/11/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView {
    
    
    // MARK: Public properties
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    // MARK: Init
    init() {
        let rowLayout = RowLayout()
//        let layout = UICollectionViewFlowLayout()
//        rowLayout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        
        dataSource = self
        delegate = self
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func set(photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos =  photos
        reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension GalleryCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        let photo = photos[indexPath.row]
        
        cell.set(imageUrl: photo.postUrlString)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GalleryCollectionView: UICollectionViewDelegate {
    
}

// MARK
extension GalleryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width,
                      height:frame.height)
    }
}