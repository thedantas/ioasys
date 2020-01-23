//
//  SplashViewController.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper


//MARK: Protocol Splah
protocol SplashDelegate: class {
    func navigateToMain()
}

class SplashViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var bottomConstraints: [NSLayoutConstraint]!
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var continueButton: UIButton!
    
    
    //MARK:Variables
    
    weak var delegate: SplashDelegate?
    var animators: [UIViewPropertyAnimator] = []
    let localStorage: UserDefaultsDataStorage
    let viewModel = AuthUserResponse()
    
    //MARK: Cycle Life
    init(localStorage: UserDefaultsDataStorage) {
        self.localStorage = localStorage
        super.init(nibName: String(describing: SplashViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureViews()
    }
    
}
//MARK: Extension
extension SplashViewController {
    
    func setupViewModel() {
        viewModel.loginAuthentication()
        
      
    }
   
    func configureViews() {
        self.continueButton.layer.cornerRadius = 5.0
        self.continueButton.rx.tap.bind {
            self.delegate?.navigateToMain()
        }.disposed(by: rx.disposeBag)
    
        
        self.views?.forEach { view in
            view.layer.cornerRadius = view.frame.width / 2
        }
      
        
    }
    
    
}


