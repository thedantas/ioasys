//
//  AuthUserRouterProvider.swift
//  ioasys
//
//  Created by André  Costa Dantas on 18/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class AuthUserRouterProvider: AuthUserService {
    
    func search(_ login: String, _ password: String) -> Single<Response> {
        return self.provider.rx.request(.search(login))
    }
    
    
    //MARK: Variables
    let provider: MoyaProvider<EnterpriseRouter>
    
    //MARK: Init
    init(provider: MoyaProvider<EnterpriseRouter>) {
        self.provider = provider
    }
    
    //MARK: Functions

}


