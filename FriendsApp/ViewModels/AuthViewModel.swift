//
//  AuthViewModel.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/19.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
    var number = Observable("")
    
    func getAuthNumber(completion: @escaping (String?, Error?) -> Void) {
        var currentVerificationID = ""
        let nationCode = "+82"
        
        PhoneAuthProvider.provider().verifyPhoneNumber("\(nationCode) \(number.value)", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            currentVerificationID = verificationID!
            
            completion(currentVerificationID, nil)
        }
        
    }

}
