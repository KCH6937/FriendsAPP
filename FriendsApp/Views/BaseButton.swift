//
//  CustomButton.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/19.
//

import UIKit

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }

    func setupView() {
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    

}
