//
//  LoginViewModel.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/24.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
    
    var authNumber = Observable("")
    
    func reGetAuthNumber(number: String, completion: @escaping (String?, Error?) -> Void) {
        var currentVerificationID = ""
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+82 \(number)", uiDelegate: nil) { (verificationID, error) in
            
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

}
