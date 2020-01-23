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
//    @IBOutlet weak var largeViewLeadingConstraint: NSLayoutConstraint!
//    @IBOutlet weak var largeViewBottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var largeView: UIView!
//    @IBOutlet weak var logoImageView: UIImageView!
//    @IBOutlet weak var chuckNorrisImage: UIImageView!
//    @IBOutlet var leadingConstraints: [NSLayoutConstraint]!
    @IBOutlet var bottomConstraints: [NSLayoutConstraint]!
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var continueButton: UIButton!
    
    
    //MARK:Variables
    var extraHeaders: [String: String]?
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
        teste()
    }
    struct Constants {
        static let baseURL = URL(string: "https://empresas.ioasys.com.br/api")!
        static let apiPath = "v1/"
        static let authenticationHeaders = ["access-token", "client", "uid"]
        static let authenticationHeadersDefaultsKey = "authenticationHeaders"
    }
    
    class Animal: Mappable {
      var client: String?
      var uid: String?
        var token: String?

      required init?(map: Map) {}

      func mapping(map: Map) {
        client <- map["client"]
        uid <- map["uid"]
        token <- map["access-token"]
      }
    }
    func teste(){
        let email = "testeapple@ioasys.com.br"
        let password = "12341234"
        let urlLogin = "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in"
        
        let parameter: Parameters = [
            "email": email,
            "password": password
        ]
        
        var headers = self.extraHeaders ?? [:]
        for headerName in Constants.authenticationHeaders {
            let headerValue = UserDefaults.standard.dictionary(forKey: Constants.authenticationHeadersDefaultsKey)?[headerName]
            if let headerValue = headerValue as? String {
                headers[headerName] = headerValue
            }
        }
        
        Alamofire.request(urlLogin, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            let uu = Mapper<Animal>().map(JSONObject: response.response?.allHeaderFields)
            UserDefaults.standard.set(uu?.client, forKey: "client")
            UserDefaults.standard.set(uu?.uid, forKey: "uid")
            UserDefaults.standard.set(uu?.token, forKey: "access-token")
       
            switch response.result {
            case .success(let data):
                print("POST: \(data)")

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
    
        
        self.views?.forEach { view in
            view.layer.cornerRadius = view.frame.width / 2
        }
      
        
    }
    
    
}


