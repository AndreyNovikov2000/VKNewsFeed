//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Andrey Novikov on 3/31/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
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
