//
//  LoginViewModel.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseMessaging

class LoginViewModel {
    
    var authNumber = Observable("")
    
    func reGetAuthNumber(number: String, completion: @escaping (String?, Error?) -> Void) {
        var currentVerificationID = ""
        let nationCode = "+82"
        
        PhoneAuthProvider.provider().verifyPhoneNumber("\(nationCode) \(number)", uiDelegate: nil) { (verificationID, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            currentVerificationID = verificationID!
            
            completion(currentVerificationID, nil)
        }
        
    }
    
    func authComplete(currentVerificationID: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationID, verificationCode: authNumber.value)
        
        Auth.auth().signIn(with: credential) { result, error in
            
            if error == nil {
                print("인증 성공")
                print(result)
                completion(result, nil)
            } else {
                print("인증 실패")
                print(error)
                completion(nil, error)
            }
            
        }
        
    }

    func getIDToken(completion: @escaping (String?, Error?) -> Void) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let idToken = idToken {
                completion(idToken, nil)
            }
            
            if let error = error {
                // id 토큰을 못받아왔을 때
                completion(nil, error)
                return;
            }
            
        }

    }

}
