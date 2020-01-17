//
//  EnterpriseRouter.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Moya

//MARK: Enum
enum EnterpriseRouter {
    case categories
    case search(String)
}

//MARK: Extension
extension EnterpriseRouter: TargetType {
    
    //MARK: Variables
    var baseURL: URL {
        return URL(string: BaseURLConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/enterprises?&name"
        }
    }
    
    var method: Method {
        return .get
    }
    var header: HeaderView{
        return .init()
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
        case .categories:
            return nil
        case .search(let query):
            return ["query": query]
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

