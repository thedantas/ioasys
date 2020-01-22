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
    let localStorage: UserDefaultsDataStorage
    var viewModel: AuthUserViewModel!
    
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
    
    func setupViewModel(){
        self.viewModel = AuthUserViewModel()
        let serverUrl = "/Test/login"
        teste()

    }
    func teste(){
         let email = "testeapple@ioasys.com.br"
         let password = "12341234"
        
       // let vcbMasuk = HomeTabBarController()
        let urlLis = "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in"
        
        let parameter: Parameters = [
            "email": email,
            "password": password
        ]
        
  
            Alamofire.request(urlLis, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let data):
                        print("isi: \(data)")
                        print(response)
                        
                     //   self.navigationController?.pushViewController(vcbMasuk, animated: true)
                        
                    case .failure(let error):
                    print("oi")
                        
                      //  self.present(alert, animated: true, completion: nil)
                        print("need text")
                        print("Request failed with error: \(error)")
                 }
            }
    }
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


