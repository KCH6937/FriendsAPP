//
//  EmailViewController.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/24.
//

import UIKit

class EmailViewController: UIViewController {
    
    let emailView = EmailView()
    let emailViewModel = EmailViewModel()
    
    override func loadView() {
        self.view = emailView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEvent()
    }
    
    func setEvent() {
        emailViewModel.email.bind { text in
            self.emailView.emailTextField.text = text
        }
        
        emailView.emailTextField.addTarget(self, action: #selector(authNumberTextFieldDidChange(_:)), for: .editingChanged)
        emailView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
    }
    
    func checkRegex(number: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        guard number.range(of: regex, options: .regularExpression) != nil else {
            return false
        }
        return true
        
    }
    
    func setBorderColor(text: String) {
        if text != "" {
            emailView.border.backgroundColor = .focus()
        } else {
            emailView.border.backgroundColor = .gray3()
        }
        
    }
    
    func setRequestButtonStatus(isEnabled: Bool) {
        if isEnabled == true {
            emailView.nextButton.isEnabled = true
            emailView.nextButton.setButton(type: .fill, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
        } else {
            emailView.nextButton.isEnabled = false
            emailView.nextButton.setButton(type: .disable, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
        }
        
    }
    
    @objc func nextButtonClicked() {
        self.navigationController?.pushViewController(GenderViewController(), animated: true)
    }
    
    @objc func authNumberTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        setBorderColor(text: text)
        
        if text.count > 64 {
            textField.text?.removeLast()
        }
        
        let isCorrect = checkRegex(number: textField.text ?? "")
        if isCorrect {
            setRequestButtonStatus(isEnabled: true)
        } else {
            setRequestButtonStatus(isEnabled: false)
        }

        emailViewModel.email.value = textField.text ?? ""
    }
}
