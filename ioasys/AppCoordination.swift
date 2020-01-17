//
//  AppCoordination.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class AppCoordinator: Coordinator {
    
    //MARK: Variables
    let window: UIWindow
    let container: Container
    lazy var storage: UserDefaultsDataStorage = {
        container.resolve(UserDefaultsDataStorage.self)!
    }()
    var currentView: UIViewController? {
        get {
            return window.rootViewController
        }
        set {
            UIView.transition(with: self.window, duration: 0.5, options: .transitionFlipFromTop, animations: {
                self.window.rootViewController = newValue
            }, completion: nil)
        }
    }
    
    //MARK: Init
    init(window: UIWindow, container: Container) {
        self.window = window
        self.container = container
    }
    
    //MARK: Functions
    func start() {
        
            showSplashScreen()
        
    }
    
    fileprivate func showSplashScreen() {
        let view = container.resolve(SplashViewController.self)!
        view.delegate = self
        self.currentView = view
    }
    
    fileprivate func showMainView() {
        let view = container.resolve(MainView.self)!
        self.currentView = view
    }
    
}

//MARK: Extentions
extension AppCoordinator: SplashDelegate {
    func navigateToMain() {
        self.showMainView()
    }
}



