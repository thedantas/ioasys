//
//  Enterprise.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
// 

import Foundation

struct Enterprise: Decodable {
    //MARK: Variables
    let id: String
    let enterprise_name: String
    let description: String

    //MARK: Enum
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case enterprise_name = "enterprise_name"
        case description = "description"
    
    }
    
    //MARK: Init
    init(category: [String] = [],
         photo: String = "",
         enterprise_name: String = "",
         description: String = "") {
        self.id = photo
        self.enterprise_name = enterprise_name
        self.description = description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.enterprise_name = try container.decode(String.self, forKey: .enterprise_name)
        self.description = try container.decode(String.self, forKey: .description)
        self.id = try container.decode(String.self, forKey: .id)
        
    }
}

