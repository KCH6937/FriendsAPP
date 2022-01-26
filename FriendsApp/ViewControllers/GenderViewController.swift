//
//  GenderViewController.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/25.
//

import UIKit

class GenderViewController: UIViewController {
    
    let genderView = GenderView()
    let genderViewModel = GenderViewModel()
    
    override func loadView() {
        self.view = genderView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEvent()
    }
    
    func setEvent() {
        genderView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
        genderView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        genderView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func manButtonClicked() {
        genderView.manButton.backgroundColor = .whiteGreen()
        genderView.manButton.layer.borderWidth = 0
        genderView.womanButton.setButton(type: .inactive, title: "여자", font: UIFont.notoSansRegular(ofSize: 16))
        genderViewModel.gender.value = 0
    }
    
    @objc func womanButtonClicked() {
        genderView.womanButton.backgroundColor = .whiteGreen()
        genderView.womanButton.layer.borderWidth = 0
        genderView.manButton.setButton(type: .inactive, title: "남자", font: UIFont.notoSansRegular(ofSize: 16))
        genderViewModel.gender.value = 1
    }
    
    @objc func nextButtonClicked() {
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    

    
}
