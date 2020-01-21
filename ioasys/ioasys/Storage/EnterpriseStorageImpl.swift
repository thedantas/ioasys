//
//  EnterpriseStorageImpl.swift
//  ioasys
//
//  Created by André  Costa Dantas on 20/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class EnterpriseStorageImpl: EnterpriseStorage {
    
    let service: EnterpriseService
    
    init(service: EnterpriseService) {
        self.service = service
    }
    
    func search(_ query: String) -> Single<[Enterprise]> {
        return self.service.search(query)
            .map(EnterpriseResponse.self)
            .map { $0.result }
    }
}
