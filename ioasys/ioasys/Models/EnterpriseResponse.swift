//
//  EnterpriseResponse.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation

struct EnterpriseResponse: Decodable {
    let total: Int
    let result: [Enterprise]
}
