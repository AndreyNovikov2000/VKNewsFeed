//
//  NewsFeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/6/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodeCell"
    
    // MARK: - First layer
    let cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .red
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    // MARK: - Second layer
    let topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = .green
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.backgroundColor = .purple
        label.backgroundColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        return label
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return imageView
    }()
    
    let bottomView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = .blue
        return bottomView
    }()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .orange
        overlayFirstLayer()
        overlaySecondLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods
    func set(viewModel: FeedCellViewModel) {
        
        // MARK: - Cell
//        postLabel.text = viewModel.text

        
        // MARK: - Frames
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomviewFrame
        
        // MARK: - Attachment
        if let photoAttachment = viewModel.photoAttachment {
          //  postImageView.set(imageUrl: photoAttachment.postUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }

    
    
    
    // MARK: - Constraints
    
    private func overlayFirstLayer() {
        addSubview(cardView)
        
        // CardView Constraints
        
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        // top view
        
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHieght).isActive = true
            
        // post label - dynamic 
    
    }
    
    
}
