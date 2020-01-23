//
//  AuthUserResponse.swift
//  ioasys
//
//  Created by Andre Costa Dantas on 17/01/20.
//  Copyright © 2020 Andre Costa Dantas. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import ObjectMapper
import UIKit

struct ConstantsLogin {
       static let baseURL = URL(string: "https://empresas.ioasys.com.br/api")!
       static let apiPath = "v1/"
       static let authenticationHeaders = ["access-token", "client", "uid"]
       static let authenticationHeadersDefaultsKey = "authenticationHeaders"
   }
class AuthUserResponse {

  var extraHeaders: [String: String]?
   func loginAuthentication(){
       let email = "testeapple@ioasys.com.br"
       let password = "12341234"
       let urlLogin = "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in"
       
       let parameter: Parameters = [
           "email": email,
           "password": password
       ]
       var headers = self.extraHeaders ?? [:]
       for headerName in ConstantsLogin.authenticationHeaders {
           let headerValue = UserDefaults.standard.dictionary(forKey: ConstantsLogin.authenticationHeadersDefaultsKey)?[headerName]
           if let headerValue = headerValue as? String {
               headers[headerName] = headerValue
           }
       }
       
       Alamofire.request(urlLogin, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON {
           response in
           let uu = Mapper<AuthUser>().map(JSONObject: response.response?.allHeaderFields)
           UserDefaults.standard.set(uu?.client, forKey: "client")
           UserDefaults.standard.set(uu?.uid, forKey: "uid")
           UserDefaults.standard.set(uu?.token, forKey: "access-token")
      
           switch response.result {
           case .success(let data):
               print("POST: \(data)")

           case .failure(let error):
   
               print("Request failed with error: \(error)")
           }
       }
       
       
   }
}
