//
//  AuthUser.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation

struct AuthUser: Decodable {
    //MARK: Variables
    let id: String
    let login: String
    let password: String

    //MARK: Enum
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case password

    }

    //MARK: Init
    init(category: [String] = [],
         id: String = "",
         login: String = "",
         password: String = "") {
        self.id = id
        self.login = login
        self.password = password
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.login  = try container.decode(String.self, forKey: .login)
        self.password = try container.decode(String.self, forKey: .password)

    }
}

