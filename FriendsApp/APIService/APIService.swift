//
//  APIService.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService {
    
    static let shared = APIService()
    
    typealias CompletionHandler = (Int, JSON?) -> ()
    
    func getUser(idToken: String, result: @escaping CompletionHandler) {
        let httpHeaders = HTTPHeaders.init([HTTPHeader(name: "idtoken", value: idToken)])
        
        AF.request("\(EndPoint.url)/user", method: .get, headers: httpHeaders).validate(statusCode: 200...501).response { response in
            switch response.result {
                
            case .success:
                print("너뭐하닞")
                let code = response.response?.statusCode ?? 500 // statuscode가 nil일 떄 500
                result(code, nil)
                
            case .failure(let error): // Network Error (통신 실패)
                print(error)
                
            }
            
        }
        
    }
    
    func signInUser(idToken: String, result: @escaping CompletionHandler) {
        let httpHeaders = HTTPHeaders.init([HTTPHeader(name: "idtoken", value: idToken)])
        
        
        print(UserDefaults.standard.object(forKey: "phoneNumber") as! String)
        print(UserDefaults.standard.object(forKey: "FCMtoken") as! String)
        print(UserDefaults.standard.object(forKey: "nick") as! String)
        print(UserDefaults.standard.object(forKey: "birth") as! String)
        print(UserDefaults.standard.object(forKey: "email") as! String)
        print(UserDefaults.standard.object(forKey: "gender") as! Int)
        
        let parameters: [String: Any] = [
            "phoneNumber": UserDefaults.standard.object(forKey: "phoneNumber") as! String,
            "FCMtoken": UserDefaults.standard.object(forKey: "FCMtoken") as! String,
            "nick": UserDefaults.standard.object(forKey: "nick") as! String,
            "birth": UserDefaults.standard.object(forKey: "birth") as! String,
            "email": UserDefaults.standard.object(forKey: "email") as! String,
            "gender": UserDefaults.standard.object(forKey: "gender") as! Int
        ]
        
        AF.request("\(EndPoint.url)/user", method: .post, parameters: parameters, headers: httpHeaders).validate(statusCode: 200...501).response { response in
            switch response.result {
                
            case .success:
                let code = response.response?.statusCode ?? 500 // statuscode가 nil일 떄 500
                result(code, nil)
                
            case .failure(let error): // Network Error (통신 실패)
                print(error)
                
            }
        }
    }
    
}
