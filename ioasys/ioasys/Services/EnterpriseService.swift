//
//  EnterpriseService.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import RxSwift
import Moya

//MARK: Protocol
protocol EnterpriseService {
    func search(_ query: String) -> Single<Response>
}
