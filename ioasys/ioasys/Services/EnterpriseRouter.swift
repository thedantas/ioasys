//
//  EnterpriseRouter.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//  https://empresas.ioasys.com.br/api/v1/enterprises?&name=Ar

import Moya

//MARK: Enum
enum EnterpriseRouter {
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
            return "/enterprises"
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
            return ["&name": query]
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

         let authenticationHeaders = ["access-token": "bgUkCJbP-K4zlyICQ6Mi7Q", "client": "OF4_wOKMesMpPt6SoTc4ew", "uid": "testeapple@ioasys.com.br"]
        return authenticationHeaders
    }
}

