//
//  GalleryCollectionViewCell.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/11/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    var photoImageView: WebImageView = {
        let imageview = WebImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = .green
        return imageview
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        setupConstraintsForPhotoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    //
    func set(imageUrl: String?) {
        photoImageView.set(imageUrl: imageUrl)
    }
    
    // MARK: - Private methods
    private func setupConstraintsForPhotoImageView() {
        addSubview(photoImageView)
        
        photoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
