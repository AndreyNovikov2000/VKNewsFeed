//
//  TitleView.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/17/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

class TitleView: UIView {
    
    // MARK: - UI
    private var myTextField = InsetableTextField()
    
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(myAvatarView)
        addSubview(myTextField)

        makeConstraintsForAvatarView()
        makeConstraintsForTextField()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override methods
    override var intrinsicContentSize: CGSize { return UIView.layoutFittingExpandedSize }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.height / 2
    }
    
    // MARK: - Public methods
    func set(viewModel: TitleViewViewModel) {
        myAvatarView.set(imageUrl: viewModel.photoUrlString)
    }
    
    // MARK: - Private properties
    private func makeConstraintsForAvatarView() {
        
        myAvatarView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        myAvatarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        myAvatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func makeConstraintsForTextField() {

        myTextField.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        myTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        myTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        myTextField.trailingAnchor.constraint(equalTo: myAvatarView.leadingAnchor, constant: -12).isActive = true
    }
}
