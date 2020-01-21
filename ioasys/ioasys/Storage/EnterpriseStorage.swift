//
//  EnterpriseStorage.swift
//  ioasys
//
//  Created by André  Costa Dantas on 20/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import RxSwift
import Moya

protocol EnterpriseStorage: class {
    func search(_ query: String) -> Single<[Enterprise]>
}

struct EnterpriseError: LocalizedError {
    let message: String
    
    init(message: String = "Error. If you had any problems, contact André Dantas to resolven") {
        self.message = message
    }
    
    var errorDescription: String? {
        return self.message
    }
}

