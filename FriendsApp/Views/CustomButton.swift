//
//  CustomButton.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/21.
//

import UIKit

enum Status: Int {
    case inactive
    case fill
    case outline
    case cancel
    case disable
}

final class CustomButton: BaseButton {
    
    override func setupView() {
        super.setupView()
    
    }
    
    func setButton(type: Status, title: String, font: UIFont) {
        setStatus(type: type)
        setTitle(title, for: .normal)
        titleLabel?.font = font
    }
    
    func setStatus(type: Status) {
        switch type {
        case .inactive:
            self.backgroundColor = .white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.gray5().cgColor
            self.titleLabel?.textColor = .black
            break
        case .fill:
            self.backgroundColor = .green()
            self.titleLabel?.textColor = .white
            break
        case .outline:
            self.backgroundColor = .white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.green().cgColor
            self.titleLabel?.textColor = .green()
            break
        case .cancel:
            self.backgroundColor = .gray2()
            self.titleLabel?.textColor = .black
            break
        case .disable:
            self.backgroundColor = .gray6()
            self.titleLabel?.textColor = .gray3()
            break
        }
    }
}


var typeBool:Bool = true

var maleTap = typeBool

var femaleTap = !typeBool
