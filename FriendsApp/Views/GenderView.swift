//
//  GenderView.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/25.
//

import UIKit
import SnapKit
import Then

class GenderView: UIView, ViewRepresentable {
    
    let descriptionLabel = UILabel().then {
        $0.text = "성별을 선택해 주세요"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.notoSansRegular(ofSize: 20)
    }
    
    let subDescriptionLabel = UILabel().then {
        $0.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        $0.textAlignment = .center
        $0.textColor = .gray7()
        $0.font = UIFont.notoSansRegular(ofSize: 16)
    }
    
    let manButton = CustomButton().then {
        $0.setButton(type: .inactive, title: "남자", font: UIFont.notoSansRegular(ofSize: 16))
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(UIImage(named: "man"), for: .normal)
        $0.contentHorizontalAlignment = .center
    }
    
    let womanButton = CustomButton().then {
        $0.setButton(type: .inactive, title: "여자", font: UIFont.notoSansRegular(ofSize: 16))
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(UIImage(named: "woman"), for: .normal)
        $0.contentHorizontalAlignment = .center
    }
    
    let nextButton = CustomButton().then {
        $0.setButton(type: .fill, title: "다음", font: UIFont.notoSansRegular(ofSize: 14))
    }
    
    let genderStackView = UIStackView().then {
        $0.spacing = 15
        $0.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        
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
        
        [manButton, womanButton].forEach {
            genderStackView.addArrangedSubview($0)
        }
        self.addSubview(genderStackView)
        genderStackView.snp.makeConstraints {
            $0.top.equalTo(subDescriptionLabel.snp.bottom).offset(32)
            $0.leading.equalTo(15)
            $0.height.equalTo(120)
            $0.centerX.equalTo(self)
        }
        
        self.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(genderStackView.snp.bottom).offset(32)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(48)
        }
        
    }
    
}
