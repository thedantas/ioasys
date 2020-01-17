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
    let photo: String
    let enterprise_name: String
    let description: String

    //MARK: Enum
    enum CodingKeys: String, CodingKey {
        case photo
        case enterprise_name = "enterprise_name"
        case description
    
    }
    
    //MARK: Init
    init(category: [String] = [],
         photo: String = "",
         enterprise_name: String = "",
         description: String = "") {
        self.photo = photo
        self.enterprise_name = enterprise_name
        self.description = description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.enterprise_name = try container.decode(String.self, forKey: .enterprise_name)
        self.description = try container.decode(String.self, forKey: .description)
        self.photo = try container.decode(String.self, forKey: .photo)
        
    }
}

