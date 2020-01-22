//
//  AuthUserViewModel.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 22/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AuthUserViewModel {
    
    let authUser: PublishSubject<AuthUser>
    
    let login: Driver<String>
    let password: Driver<String>
    let id: Driver<String>
    
    init() {
        self.authUser = PublishSubject<AuthUser>()
        
        self.login = self.authUser
            .map { $0.login }
            .asDriver(onErrorJustReturn: "")
        
        self.password = self.authUser
            .map { $0.password }
            .asDriver(onErrorJustReturn: "")
        
        self.id = self.authUser
            .map { $0.id }
            .asDriver(onErrorJustReturn: "")
        


    }
    
    func bind(_ auth: AuthUser) {
        self.authUser.onNext(auth)
        
    }
    
}

