//
//  AuthView.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/19.
//

import UIKit
import SnapKit
import Then

class LoginView: UIView, ViewRepresentable {
    
    let descriptionLabel = UILabel().then {
        $0.text = "인증번호가 문자로 전송되었어요"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 20)
    }
    
    let consumptionLabel = UILabel().then {
        $0.text = "(최대 소모 20초)"
        $0.textAlignment = .center
        $0.textColor = .gray7()
        $0.font = UIFont.notoSansRegular(ofSize: 16)
    }
    
    let authNumberTextField = UITextField().then {
        $0.placeholder = "인증번호 입력"
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 14)
        $0.keyboardType = .numberPad
    }
    
    let authAndStartButton = CustomButton().then {
        $0.setButton(type: .disable, title: "인증하고 시작하기", font: UIFont.notoSansRegular(ofSize: 14))
    }
    
    let reRequestButton = CustomButton().then {
        $0.setButton(type: .fill, title: "재전송", font: UIFont.notoSansRegular(ofSize: 14))
    }
    
    let border = UIView().then {
        $0.backgroundColor = .gray3()
        $0.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    }
    
    let authLimitLabel = UILabel().then {
        $0.textColor = .green()
        $0.font = UIFont.notoSansMedium(ofSize: 14)
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        authNumberTextField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        authAndStartButton.isEnabled = false
    }
    
    func setupConstraints() {
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(80)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        self.addSubview(consumptionLabel)
        consumptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
            
        self.addSubview(authNumberTextField)
        authNumberTextField.snp.makeConstraints {
            $0.top.equalTo(consumptionLabel.snp.bottom).offset(76)
            $0.leading.equalTo(self).offset(28)
        }
        
        self.addSubview(authLimitLabel)
        authLimitLabel.snp.makeConstraints {
            $0.top.equalTo(consumptionLabel.snp.bottom).offset(76)
            $0.trailing.equalTo(self).offset(-102)
        }
        
        self.addSubview(reRequestButton)
        reRequestButton.snp.makeConstraints {
            $0.top.equalTo(consumptionLabel.snp.bottom).offset(69)
            $0.trailing.equalTo(self).offset(-16)
            $0.width.equalTo(72)
            $0.height.equalTo(40)
        }

        self.addSubview(border)
        border.snp.makeConstraints {
            $0.top.equalTo(authNumberTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-96)
            $0.height.equalTo(1)
        }
        
        self.addSubview(authAndStartButton)
        authAndStartButton.snp.makeConstraints {
            $0.top.equalTo(border.snp.bottom).offset(72)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(48)
        }
        
    }

}
