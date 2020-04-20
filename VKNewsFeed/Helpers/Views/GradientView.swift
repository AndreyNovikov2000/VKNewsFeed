//
//  GradientView.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 4/20/20.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit


class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor? {
        didSet {
            setupGradintView()
        }
    }
    @IBInspectable private var endColor: UIColor? {
        didSet {
            setupGradintView()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        setupGradintView()
    }
    
    private func setupGradintView() {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
    
}
