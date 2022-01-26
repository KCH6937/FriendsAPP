//
//  AuthView.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/19.
//

import UIKit
import SnapKit
import Then

class AuthView: UIView, ViewRepresentable {
        
    let descriptionLabel = UILabel().then {
        $0.text = "새싹 서비스 이용을 위해\n휴대폰 번호를 입력해 주세요"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 20)
    }
    
    let numberTextField = UITextField().then {
        $0.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 14)
        $0.keyboardType = .numberPad
    }
    
    let requestButton = CustomButton().then {
        $0.setButton(type: .disable, title: "인증 문자 받기", font: UIFont.notoSansRegular(ofSize: 14))
    }
    
    let reRequestButton = CustomButton().then {
        $0.setButton(type: .fill, title: "재전송", font: UIFont.notoSansRegular(ofSize: 14))
    }
    
    let border = UIView().then {
        $0.backgroundColor = .gray3()
        $0.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numberTextField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        requestButton.isEnabled = false
    }
    
    func setupConstraints() {
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(125)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        self.addSubview(numberTextField)
        numberTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(77)
            $0.leading.equalTo(self).offset(28)
            $0.trailing.equalTo(self).offset(-28)
        }
        
        self.addSubview(border)
        border.snp.makeConstraints {
            $0.top.equalTo(numberTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(1)
        }
        
        self.addSubview(requestButton)
        requestButton.snp.makeConstraints {
            $0.top.equalTo(border.snp.bottom).offset(72)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(48)
        }
        
    }

}
