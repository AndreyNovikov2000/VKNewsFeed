//
//  NewsFeedCell.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/1/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String { get }
    var likes: String? { get }
    var commets: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var postUrlString: String? { get }
    var width: Int { get }
    var hieght: Int { get }
}

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.bounds.width / 2
        iconImageView.clipsToBounds = true
    }
    
    // MARK: - Public methods
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.commets
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.set(imageUrl: photoAttachment.postUrlString)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
}
