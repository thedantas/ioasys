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
    case enterprises(String)
    case categories
}

//MARK: Extension
extension EnterpriseRouter: TargetType {
    
    //MARK: Variables
    var baseURL: URL {
        return URL(string: BaseURLConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .enterprises:
            return "/enterprises"
        case .categories:
             return "/enterprises"
        }
    }
    
    var method: Method {
        return .get
    }
   
    var sampleData: Data {
        switch self {
        case .enterprises:
            let data = ["enterprises": [
                                    "id": "id",
                                    "enterprise_name": "thedantas.com",
                                    "description": "blablabla"]
                ] as [String: Any]
            return jsonSerializedUTF8(json: data)
        case .categories:
            let data = ["animal", "career", "celebrity"]
                       return arrayJsonSerializedUTF8(json: data)
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .enterprises(let query):
            return ["&name": query]
        case .categories:
        return nil
            
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

        let authenticationHeaders = ["access-token": UserDefaults.standard.string(forKey: "access-token"), "client": UserDefaults.standard.string(forKey: "client"), "uid": UserDefaults.standard.string(forKey: "uid")]
        return (authenticationHeaders as! [String : String])
    }
}

