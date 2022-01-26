//
//  ViewController.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/19.
//

/*
Todo:
 - 이미 가입한 회원 처리(홈화면 이동)
 - 에러 처리 등 (Toast Message)
 - 키보드 위에(SMS 인증번호 가져오기 기능)
 - 인증번호 유효기간(5분)
 - status code
    - 200: 홈 화면으로
    - 201: 닉네임 화면으로
 - 재요청 시 타이머 리셋
*/

import UIKit

class LoginViewController: UIViewController {
    
    var currentVerificationID = ""
    var phoneNumber = ""
    var timer = Timer()
    var totalSecond = 60
    
    let loginView = LoginView()
    let loginViewModel = LoginViewModel()

    override func loadView() {
        self.view = loginView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setEvent()
        startTimer()
    }
    
    func setNavButton() {
        self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(backButtonClicked))
    }

    func setEvent() {
        loginViewModel.authNumber.bind { text in
            self.loginView.authNumberTextField.text = text
        }
        
        loginView.authNumberTextField.addTarget(self, action: #selector(authNumberTextFieldDidChange(_:)), for: .editingChanged)
        loginView.authAndStartButton.addTarget(self, action: #selector(authAndStartButtonClicked), for: .touchUpInside)
        loginView.reRequestButton.addTarget(self, action: #selector(reRequestButtonClicked), for: .touchUpInside)
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }

    func endTimer() {
        timer.invalidate()
        ifTimeEnd()
    }
    
    func ifTimeEnd() {
        loginView.authLimitLabel.text = ""
        loginView.authNumberTextField.text = ""
        loginView.authNumberTextField.isEnabled = false
    }
    
    func ifTimeStart() {
        loginView.authNumberTextField.text = ""
        loginView.authNumberTextField.isEnabled = true
        totalSecond = 60
        startTimer()
    }
    

    func timeFormatted(_ totalSeconds: Int) -> String {
        let minutes: Int = totalSeconds / 60
        let seconds: Int = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func checkRegex(number: String) -> Bool {
        let regex = "^([0-9]{6})$"

        guard number.range(of: regex, options: .regularExpression) != nil else {
            return false
        }
        return true
        
    }
    
    func setBorderColor(text: String) {
        if text != "" {
            loginView.border.backgroundColor = .focus()
        } else {
            loginView.border.backgroundColor = .gray3()
        }
        
    }
    
    func setRequestButtonStatus(isEnabled: Bool) {
        if isEnabled == true {
            loginView.authAndStartButton.isEnabled = true
            loginView.authAndStartButton.setButton(type: .fill, title: "인증하고 시작하기", font: UIFont.notoSansRegular(ofSize: 14))
        } else {
            loginView.authAndStartButton.isEnabled = false
            loginView.authAndStartButton.setButton(type: .disable, title: "인증하고 시작하기", font: UIFont.notoSansRegular(ofSize: 14))
        }
        
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func reRequestButtonClicked() {
        
        loginViewModel.reGetAuthNumber(number: phoneNumber) { currentVerificationID, error in
            
            if let currentVerificationID = currentVerificationID {
                self.currentVerificationID = currentVerificationID
                self.ifTimeStart()
            }
            
            if let error = error {
                print(error)
            }
            
        }
        
    }
    
    @objc func authAndStartButtonClicked() {
        loginViewModel.authComplete(currentVerificationID: self.currentVerificationID) { result, error in
            
            if let result = result {
                print(result)
                self.navigationController?.pushViewController(NicknameViewController(), animated: true)
            }
            
            if let error = error {
                print(error)
            }
            
        }
    }
    
    @objc func authNumberTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        setBorderColor(text: text)
        
        if text.count > 6 {
            textField.text?.removeLast()
        }
        
        let isCorrect = checkRegex(number: textField.text ?? "")
        if isCorrect {
            setRequestButtonStatus(isEnabled: true)
        } else {
            setRequestButtonStatus(isEnabled: false)
        }

        loginViewModel.authNumber.value = textField.text ?? ""
        
    }
    
    @objc func updateTime() {

        loginView.authLimitLabel.text = timeFormatted(totalSecond)

         if totalSecond != 0 {
            totalSecond -= 1
         } else {
            endTimer()
         }
    }

}
