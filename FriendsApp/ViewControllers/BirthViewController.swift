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
    
    let date = Date()
    
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
        birthView.datePicker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
        birthView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func setPickerView() {
        let nextFieldButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(nextFieldButtonClicked))
        nextFieldButton.tintColor = .green
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        birthView.toolBar.setItems([flexSpace,nextFieldButton], animated: true)
        
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
    
    func setBorderColor(text: String, border: UIView) {
        if text != "" {
            border.backgroundColor = .focus()
        } else {
            border.backgroundColor = .gray3()
        }
        
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
    
    @objc func handleDatePicker(_ sender: UIDatePicker) {
        
    }
    
    @objc func nextButtonClicked() {
        UserDefaults.standard.set("value", forKey: "birth")
        self.navigationController?.pushViewController(EmailViewController(), animated: true)
    }
    
    @objc func nextFieldButtonClicked() {
        if birthView.yearTextField.isEditing {
            birthView.yearTextField.resignFirstResponder()
            birthView.monthTextField.becomeFirstResponder()
            
        } else if birthView.monthTextField.isEditing {
            birthView.monthTextField.resignFirstResponder()
            birthView.dayTextField.becomeFirstResponder()
            
        } else if birthView.dayTextField.isEditing {
            birthView.dayTextField.resignFirstResponder()
        }
        
    }
    
}

//extension BirthViewController: UIDAte {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if birthView.yearTextField.isEditing {
//            return "\(year[row])년"
//        } else if birthView.monthTextField.isEditing {
//            return "\(month[row])월"
//        } else if birthView.dayTextField.isEditing {
//            return "\(day[row])일"
//        } else {
//            return ""
//        }
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if birthView.yearTextField.isEditing {
//            return year.count
//        } else if birthView.monthTextField.isEditing {
//            return month.count
//        } else if birthView.dayTextField.isEditing {
//            return day.count
//        } else {
//            return 0
//        }
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if birthView.yearTextField.isEditing {
//            birthViewModel.year.value = year[row]
//        } else if birthView.monthTextField.isEditing {
//            birthViewModel.month.value = month[row]
//        } else if birthView.dayTextField.isEditing {
//            birthViewModel.day.value = day[row]
//        }
//
//    }
//
//}
