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
    
    func login(_ login: String, _ password: String) -> Single<Response> {
        return self.provider.rx.request(.search(login, password))
    }

    //MARK: Variables
    //let provider: MoyaProvider<AuthUserRouter>
    var provider = MoyaProvider<AuthUserRouter>(plugins: [CredentialsPlugin { _ -> URLCredential? in
            return URLCredential(user: "email", password: "password", persistence: .none)
        }
    ])
    
    //MARK: Init
    init(provider: MoyaProvider<AuthUserRouter>) {
        self.provider = provider
    }
    

}


