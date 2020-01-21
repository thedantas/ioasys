//
//  AuthUserRouter.swift
//  ioasys
//
//  Created by André  Costa Dantas on 18/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Moya

//MARK: Enum
enum AuthUserRouter {
    case search(String,String)
}


//MARK: Extension
extension AuthUserRouter: TargetType {
    
    //MARK: Variables
    var baseURL: URL {
        return URL(string: BaseURLConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .search:
            return "users/auth/"
        }
    }
    
    var method: Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .search:
            let data = ["total": 6,
                        "result": [["category": ["dev"],
                                    "id": "id",
                                    "url": "thedantas.com",
                                    "value": "blablabla"]
                ]] as [String: Any]
            return jsonSerializedUTF8(json: data)
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .search(let query):
            return ["sign_in": query]
        }
    }
    
    var task: Task {
        if let `parameters` = parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        } else {
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}


