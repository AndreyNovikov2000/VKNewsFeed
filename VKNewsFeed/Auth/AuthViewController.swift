//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Алексей Пархоменко on 22/02/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    // MARK: Private properties
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AppDelegate.shared().authService
    }
    
    
    @IBAction func signInTouch() {
        authService.wakeUpSession()
    }
}
