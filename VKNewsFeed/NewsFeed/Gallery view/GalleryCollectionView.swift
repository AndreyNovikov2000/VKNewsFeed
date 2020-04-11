//
//  GalleryCollectionView.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/11/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView {
    
    var photos = [FeedCellPhotoAttachmentViewModel]()
    
    //
    
    // MARK: Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        dataSource = self
        delegate = self
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
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

extension GalleryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: frame.width,
                      height:frame.height)
    }
}
