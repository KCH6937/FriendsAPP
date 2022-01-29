//
//  ViewController.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/19.
//

/*
Todo:
 - 텍스트필드 '-' 뭔가 문제있음 -> 해결
 - 에러 처리 등 (Toast Message)
 - 전화번호 형식 -> 해결
 - MVVM 개념에 대해 더 알아보기.. ex) 뷰컨트롤러에서 함수를 실행해서 뷰모델에서 로직을 처리하는 방식 by 강호님
 - 키보드랑 같이 화면 위로 밀어주기.. (모든 화면)
 - 중복코드 다 없애기(전체적으로) -> 설 때 하자..
*/

import UIKit

class AuthViewController: UIViewController {

    let authView = AuthView()
    let authViewModel = AuthViewModel()
    var lastString = ""
    
    override func loadView() {
        self.view = authView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavButton()
        setEvent()
    }

    func setNavButton() {
        let backBarButtonItem = UIBarButtonItem(title: "123", style: .plain, target: self, action: nil)
        backBarButtonItem.image = UIImage(systemName: "arrow.left")
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem

    }

    func setEvent() {
        authViewModel.number.bind { text in
            self.authView.numberTextField.text = text
        }
        
        authView.numberTextField.delegate = self
        authView.requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    func checkRegex(number: String) -> Bool {
        let regex = "^01([0-9])-([0-9]{3,4})-([0-9]{4})$"

        guard number.range(of: regex, options: .regularExpression) != nil else {
            return false
        }
        return true
        
    }
    
    func setBorderColor(text: String) {
        if text != "" {
            authView.border.backgroundColor = .focus()
        } else {
            authView.border.backgroundColor = .gray3()
        }
        
    }
    
    func setRequestButtonStatus(isEnabled: Bool) {
        if isEnabled == true {
            authView.requestButton.isEnabled = true
            authView.requestButton.setButton(type: .fill, title: "인증 문자 받기", font: UIFont.notoSansRegular(ofSize: 14))
        } else {
            authView.requestButton.isEnabled = false
            authView.requestButton.setButton(type: .disable, title: "인증 문자 받기", font: UIFont.notoSansRegular(ofSize: 14))
        }
        
    }
    
    @objc func requestButtonClicked() {
        authViewModel.getAuthNumber { currentVerificationID, error in
            if let currentVerificationID = currentVerificationID {
                let loginViewController = LoginViewController()
                loginViewController.currentVerificationID = currentVerificationID
                loginViewController.phoneNumber = self.authViewModel.number.value
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
            
            if let error = error {
                print(error)
            }
            
        }
        
    }

}

extension AuthViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.formatPhoneNumber(range: range, string: string)
        
        setBorderColor(text: textField.text ?? "")
        setRequestButtonStatus(isEnabled: checkRegex(number: textField.text ?? ""))
        
        authViewModel.number.value = textField.text ?? ""
        
        return false
    }
    
}
