//
//  AuthUserService.swift
//  ioasys
//
//  Created by André  Costa Dantas on 18/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import RxSwift
import Moya

//MARK: Protocol
protocol AuthUserService {
    func login(_ login: String, _ password: String) -> Single<Response>
}
