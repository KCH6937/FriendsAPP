//
//  BirthView.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/24.
//

import UIKit

class BirthView: UIView, ViewRepresentable {
    
    let toolBar = UIToolbar().then {
        $0.sizeToFit()
        $0.frame = CGRect(x: 0, y: 0, width: 0, height: 40)
    }
    
    let pickerView = UIPickerView()
    
    let descriptionLabel = UILabel().then {
        $0.text = "생년월일을 알려주세요"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 20)
    }
    
    let yearLabel = UILabel().then {
        $0.text = "년"
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 16)
    }
    
    let monthLabel = UILabel().then {
        $0.text = "월"
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 16)
    }
    
    let dayLabel = UILabel().then {
        $0.text = "일"
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 16)
    }
    
    let yearTextField = UITextField().then {
        $0.placeholder = "1990"
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 14)
        $0.tintColor = .clear
    }
    
    let monthTextField = UITextField().then {
        $0.placeholder = "1"
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 14)
        $0.tintColor = .clear
    }
    
    let dayTextField = UITextField().then {
        $0.placeholder = "1"
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 14)
        $0.tintColor = .clear
    }
    
    let yearBorder = UIView().then {
        $0.backgroundColor = .gray3()
        $0.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    }
    
    let monthBorder = UIView().then {
        $0.backgroundColor = .gray3()
        $0.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    }
    
    let dayBorder = UIView().then {
        $0.backgroundColor = .gray3()
        $0.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    }
    
    let nextButton = CustomButton().then {
        $0.setButton(type: .fill, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
    }
    
    let yearStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 40
    }
    
    let monthStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 56
    }
    
    let dayStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 56
    }
    
    let dateStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 35
    }
    
    let borderStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 42
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        yearTextField.resignFirstResponder()
        monthTextField.resignFirstResponder()
        dayTextField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        yearTextField.inputView = pickerView
        monthTextField.inputView = pickerView
        dayTextField.inputView = pickerView
        toolBar.isUserInteractionEnabled = true
        yearTextField.inputAccessoryView = toolBar
        monthTextField.inputAccessoryView = toolBar
        dayTextField.inputAccessoryView = toolBar
    }
    
    func setupConstraints() {
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(97)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        [yearTextField, yearLabel].forEach {
            yearStackView.addArrangedSubview($0)
        }
        yearTextField.snp.makeConstraints {
            $0.width.equalTo(32)
        }
        
        [monthTextField, monthLabel].forEach {
            monthStackView.addArrangedSubview($0)
        }
        monthTextField.snp.makeConstraints {
            $0.width.equalTo(16)
        }
        
        [dayTextField, dayLabel].forEach {
            dayStackView.addArrangedSubview($0)
        }
        dayTextField.snp.makeConstraints {
            $0.width.equalTo(16)
        }
        
        [yearStackView, monthStackView, dayStackView].forEach {
            dateStackView.addArrangedSubview($0)
        }
        self.addSubview(dateStackView)
        dateStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(91)
            $0.leading.equalTo(self).offset(28)
            $0.trailing.equalTo(self).offset(-16)
        }
        
        [yearBorder, monthBorder, dayBorder].forEach {
            borderStackView.addArrangedSubview($0)
        }
        self.addSubview(borderStackView)
        borderStackView.snp.makeConstraints {
            $0.top.equalTo(dateStackView.snp.bottom).offset(12)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-35)
            $0.height.equalTo(1)
        }
        
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(monthBorder.snp.bottom).offset(72)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(48)
        }
        
    }
    
}
