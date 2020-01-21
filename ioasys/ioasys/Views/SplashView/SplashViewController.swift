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

//MARK: Protocol Splah
protocol SplashDelegate: class {
    func navigateToMain()
}

class SplashViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var largeViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var largeViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var largeView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var chuckNorrisImage: UIImageView!
    @IBOutlet var leadingConstraints: [NSLayoutConstraint]!
    @IBOutlet var bottomConstraints: [NSLayoutConstraint]!
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK:Variables
    weak var delegate: SplashDelegate?
    var animators: [UIViewPropertyAnimator] = []
    
    //MARK: Cycle Life
    init() {
        super.init(nibName: String(describing: SplashViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureViews()
    }
    
}
//MARK: Extension
extension SplashViewController {
    
    func configureViews() {
        self.continueButton.layer.cornerRadius = 5.0
        self.continueButton.rx.tap.bind {
            self.delegate?.navigateToMain()
        }.disposed(by: rx.disposeBag)
        
        self.largeView?.layer.cornerRadius = (largeView?.frame.width)! / 2
        
        self.views?.forEach { view in
            view.layer.cornerRadius = view.frame.width / 2
        }
        largeView?.rotate()
        
    }
    

}


