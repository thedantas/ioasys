//
//  AuthUser.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class AuthUser: Mappable {
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
