//
//  EmailView.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/24.
//

import UIKit
import SnapKit
import Then

class EmailView: UIView, ViewRepresentable {
    
    let descriptionLabel = UILabel().then {
        $0.text = "이메일을 입력해 주세요"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 20)
    }
    
    let subDescriptionLabel = UILabel().then {
        $0.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        $0.textAlignment = .center
        $0.textColor = .gray7()
        $0.font = UIFont.notoSansRegular(ofSize: 16)
    }
    
    let emailTextField = UITextField().then {
        $0.placeholder = "SeSAC@email.com"
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 14)
    }
    
    let nextButton = CustomButton().then {
        $0.setButton(type: .disable, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
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
        emailTextField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        nextButton.isEnabled = false
    }
    
    func setupConstraints() {
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(80)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        self.addSubview(subDescriptionLabel)
        subDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
            
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(subDescriptionLabel.snp.bottom).offset(76)
            $0.leading.equalTo(self).offset(28)
            $0.trailing.equalTo(self).offset(-28)
        }

        self.addSubview(border)
        border.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(1)
        }
        
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(border.snp.bottom).offset(72)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(48)
        }
        
    }

}
