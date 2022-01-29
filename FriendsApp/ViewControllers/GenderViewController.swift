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
    
    override func viewWillAppear(_ animated: Bool) {
        loadSavedData()
    }
    
    func loadSavedData() {
        genderViewModel.gender.value = UserDefaults.standard.object(forKey: "gender") as? Int ?? -1
        if genderViewModel.gender.value == 0 {
            manButtonClicked()
        } else if genderViewModel.gender.value == 1 {
            womanButtonClicked()
        }
        
    }
    
    func setEvent() {
        genderView.manButton.addTarget(self, action: #selector(manButtonClicked), for: .touchUpInside)
        genderView.womanButton.addTarget(self, action: #selector(womanButtonClicked), for: .touchUpInside)
        genderView.nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func manButtonClicked() {
        if genderViewModel.gender.value == 0 {
            genderView.manButton.setButton(type: .inactive, title: "남자", font: UIFont.notoSansRegular(ofSize: 16))
            genderViewModel.gender.value = -1
        } else {
            genderView.manButton.backgroundColor = .whiteGreen()
            genderView.manButton.layer.borderWidth = 0
            genderView.womanButton.setButton(type: .inactive, title: "여자", font: UIFont.notoSansRegular(ofSize: 16))
            genderViewModel.gender.value = 0
        }
    }
    
    @objc func womanButtonClicked() {
        if genderViewModel.gender.value == 1 {
            genderView.womanButton.setButton(type: .inactive, title: "여자", font: UIFont.notoSansRegular(ofSize: 16))
            genderViewModel.gender.value = -1
        } else {
            genderView.womanButton.backgroundColor = .whiteGreen()
            genderView.womanButton.layer.borderWidth = 0
            genderView.manButton.setButton(type: .inactive, title: "남자", font: UIFont.notoSansRegular(ofSize: 16))
            genderViewModel.gender.value = 1
        }
    }
    
    @objc func nextButtonClicked() {
        UserDefaults.standard.set(genderViewModel.gender.value, forKey: "gender")
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
}
