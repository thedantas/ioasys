//
//  EnterpriseRouterProvider.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class NorrisServiceRouterProvider: EnterpriseService {
    
    //MARK: Variables
    let provider: MoyaProvider<EnterpriseRouter>
    
    //MARK: Init
    init(provider: MoyaProvider<EnterpriseRouter>) {
        self.provider = provider
    }
    
    //MARK: Functions
    func search(_ query: String) -> Single<Response> {
        return self.provider.rx.request(.enterprises(query))
    }
    func categories() -> Single<Response> {
           return self.provider.rx.request(.categories)
       }
}

