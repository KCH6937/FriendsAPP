//
//  NicknameViewController.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/24.
//

/*
Todo:
 - 키보드 자동으로 올리기
*/

import UIKit

class NicknameViewController: UIViewController {

    let nicknameView = NicknameView()
    let nicknameViewModel = NicknameViewModel()
    
    override func loadView() {
        self.view = nicknameView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadSavedData()
    }
    
    func loadSavedData() {
        nicknameView.nicknameTextField.text = UserDefaults.standard.object(forKey: "nick") as? String ?? ""
        if nicknameView.nicknameTextField.text == "" {
            setRequestButtonStatus(isEnabled: false)
        } else {
            setRequestButtonStatus(isEnabled: true)
        }
    }
    
    func setEvent() {
        nicknameView.nicknameTextField.becomeFirstResponder()
        
        nicknameViewModel.nickname.bind { text in
            self.nicknameView.nicknameTextField.text = text
        }
        
        nicknameView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        nicknameView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func checkRegex(text: String) -> Bool {
        let regex = "^.{1,10}$"


        guard text.range(of: regex, options: .regularExpression) != nil else {
            return false
        }
        return true
        
    }
    
    func setBorderColor(text: String) {
        if text != "" {
            nicknameView.border.backgroundColor = .focus()
        } else {
            nicknameView.border.backgroundColor = .gray3()
        }
        
    }
    
    func setRequestButtonStatus(isEnabled: Bool) {
        if isEnabled == true {
            nicknameView.nextButton.isEnabled = true
            nicknameView.nextButton.setButton(type: .fill, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
        } else {
            nicknameView.nextButton.isEnabled = false
            nicknameView.nextButton.setButton(type: .disable, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
        }
        
    }
    
    @objc func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func nextButtonClicked() {
        UserDefaults.standard.set(nicknameViewModel.nickname.value, forKey: "nick")
        self.navigationController?.pushViewController(BirthViewController(), animated: true)
    }
    
    @objc func nicknameTextFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        setBorderColor(text: text)
        
        if text.count > 10 {
            textField.text?.removeLast()
        }
        
        let isCorrect = checkRegex(text: textField.text ?? "")
        if isCorrect {
            setRequestButtonStatus(isEnabled: true)
        } else {
            setRequestButtonStatus(isEnabled: false)
        }

        nicknameViewModel.nickname.value = textField.text ?? ""

    }

}

