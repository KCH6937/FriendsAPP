//
//  BirthViewController.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/24.
//

import UIKit

class BirthViewController: UIViewController {
    
    let birthView = BirthView()
    let birthViewModel = BirthViewModel()
    
    var date = ""
    
    override func loadView() {
        self.view = birthView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setEvent()
        setPickerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadSavedData()
    }
    
    func loadSavedData() {
    }
    
    func setEvent() {
        let stackViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectBirth))
        birthView.dateStackView.addGestureRecognizer(stackViewTapGesture)
        birthView.datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        birthView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func setPickerView() {
        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonClicked))
        completeButton.tintColor = .green()
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        birthView.toolBar.setItems([flexSpace, completeButton], animated: true)
        
    }
    
    func checkRegex(number: String, type: String) -> Bool {
        var value = ""
        
        if type == "year" {
            value = "4"
        } else if type == "month" {
            value = "1,2"
        } else {
            value = "1,2"
        }

        let regex = "^([0-9]{\(value)})$"

        guard number.range(of: regex, options: .regularExpression) != nil else {
            return false
        }
        
        return true
        
    }
    
    func setContentColor() {
        birthView.yearValueLabel.textColor = .black
        birthView.monthValueLabel.textColor = .black
        birthView.dayValueLabel.textColor = .black
    }
    
    func setRequestButtonStatus(isEnabled: Bool) {
        if isEnabled == true {
            birthView.nextButton.isEnabled = true
            birthView.nextButton.setButton(type: .fill, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
        } else {
            birthView.nextButton.isEnabled = false
            birthView.nextButton.setButton(type: .disable, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
        }
        
    }
    
    @objc func selectBirth() {
        print(#function)

        birthView.yearTextField.becomeFirstResponder()
        
        birthView.datePicker.isSelected = true
        birthView.datePicker.isHighlighted = true
        
    }
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        setContentColor()
        
        let yearFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        let dayFormatter = DateFormatter()
        let dateFormatter = DateFormatter()
        
        yearFormatter.dateFormat = "yyyy"
        monthFormatter.dateFormat = "M"
        dayFormatter.dateFormat = "d"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        birthView.yearValueLabel.text = yearFormatter.string(from: sender.date)
        birthView.monthValueLabel.text = monthFormatter.string(from: sender.date)
        birthView.dayValueLabel.text = dayFormatter.string(from: sender.date)
        
        date = dateFormatter.string(from: sender.date)
        
    }
    
    @objc func nextButtonClicked() {
        UserDefaults.standard.set(date, forKey: "birth")
        self.navigationController?.pushViewController(EmailViewController(), animated: true)
    }
    
    @objc func completeButtonClicked() {
        birthView.yearTextField.resignFirstResponder()
    }
    
}
