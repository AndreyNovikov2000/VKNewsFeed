//
//  NewsFeedCodeCell.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/6/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol NewsFeedCodeCellDelegate: class {
    func revealCell(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodeCell"
    
    // MARK: External properties
    weak var cellDelegate: NewsFeedCodeCellDelegate?
    
    // MARK: - First layer
    let cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.layer.cornerRadius = 13
        return cardView
    }()
    
    // MARK: - Second layer
    let topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        return label
    }()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return imageView
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    let moreTextButtom: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.3490949869, green: 0.442735225, blue: 1, alpha: 1), for: .normal)
        button.setTitle("Show more...", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.contentVerticalAlignment = .center
        return button
    }()
    
    let bottomView: UIView = {
        let bottomView = UIView()
        return bottomView
    }()
    
    // MARK: - Third layer on top view
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.layer.cornerRadius = Constants.topViewHieght / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = #colorLiteral(red: 0.227329582, green: 0.2323184013, blue: 0.2370472848, alpha: 1)
        return label
    }()
    
    // MARK: - Third layer in bottom view
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commetsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Fourth layer on botton view
    let likesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "like")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let commetsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "comment")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let sharesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "share")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let viewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "eye")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5064757466, green: 0.5493161082, blue: 0.6010426283, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5064757466, green: 0.5493161082, blue: 0.6010426283, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5064757466, green: 0.5493161082, blue: 0.6010426283, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5064757466, green: 0.5493161082, blue: 0.6010426283, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    
    // MARK: - Live cycle methods
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        moreTextButtom.addTarget(self, action: #selector(handleMoreTextButtonTapped), for: .touchUpInside)
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThridLayerOnTopView()
        overlayThrirdLayerOnBottomView()
        overlayFourthLayerOnBottomViewViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public methods

    func set(viewModel: FeedCellViewModel) {
        
        // Cell
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.commets
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        // Frames
        postLabel.frame = viewModel.sizes.postLabelFrame
        bottomView.frame = viewModel.sizes.bottomviewFrame
        moreTextButtom.frame = viewModel.sizes.moreTextButtonFrame
        
        // Attachments
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            
            postImageView.set(imageUrl: photoAttachment.postUrlString)
            postImageView.frame = viewModel.sizes.attachmentFrame
            
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
        } else if viewModel.photoAttachments.count > 1 {
            
            galleryCollectionView.set(photos: viewModel.photoAttachments)
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
        } else {
            
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    // MARK: - Objc methods
    @objc func handleMoreTextButtonTapped() {
        cellDelegate?.revealCell(for: self)
    }
    
    // MARK: - Constraints
    
    
    // MARK: - FIRST LAYER
    private func overlayFirstLayer() {
        addSubview(cardView)
        
        // CardView Constraints
        
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
    
    // MARK: - SECOND LAYER
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(moreTextButtom)
        cardView.addSubview(bottomView)
        
        // top view
        
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topViewHieght).isActive = true
        
        // post label - dynamic items
        // postImageView - dynamic items
        // galleryCollectionView - dynamic items
        // bottomVie - dynamic items
        // moreTextButtom - dynamic items
    }
    
    // MARK: - THRID LAYER ON TOP VIEW
    private func overlayThridLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        // icon image view
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHieght).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHieght).isActive = true
        
        // name label
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 3).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        // date label
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    // MARK: - THIRD LAYER ON BOTTOM VIEW
    private func overlayThrirdLayerOnBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commetsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        // likes view
        likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        likesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHieght).isActive = true
        likesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth).isActive = true
        
        // commets view
        commetsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        commetsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        commetsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHieght).isActive = true
        commetsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth).isActive = true
        
        // shares view
        sharesView.leadingAnchor.constraint(equalTo: commetsView.trailingAnchor).isActive = true
        sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        sharesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHieght).isActive = true
        sharesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth).isActive = true
        
        // views view
        viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        viewsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        viewsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHieght).isActive = true
        viewsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewWidth).isActive = true
    }
    
    // MARK: - FOURTH LAYER ON BOTTOM VIEW
    private func overlayFourthLayerOnBottomViewViews() {
        likesView.addSubview(likesImageView)
        likesView.addSubview(likesLabel)
        
        commetsView.addSubview(commetsImageView)
        commetsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImageView)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImageView)
        viewsView.addSubview(viewsLabel)
        
        // likes constraints
        helpForFourthLayer(view: likesView, imageView: likesImageView, label: likesLabel)
        
        // commets constraints
        helpForFourthLayer(view: commetsView, imageView: commetsImageView, label: commentsLabel)
        
        // shares contraints
        helpForFourthLayer(view: sharesView, imageView: sharesImageView, label: sharesLabel)
        
        // views constraints
        helpForFourthLayer(view: viewsView, imageView: viewsImageView, label: viewsLabel)
        
    }
    
    private func helpForFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        
        // image view
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        // label
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 9).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
