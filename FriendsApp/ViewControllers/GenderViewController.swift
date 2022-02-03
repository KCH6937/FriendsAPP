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
        
        print(UserDefaults.standard.object(forKey: "gender"))
        if genderViewModel.gender.value == 0 {
            genderView.manButton.backgroundColor = .whiteGreen()
            genderView.manButton.layer.borderWidth = 0
        } else if genderViewModel.gender.value == 1 {
            genderView.womanButton.backgroundColor = .whiteGreen()
            genderView.womanButton.layer.borderWidth = 0
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
        
        UserDefaults.standard.set(genderViewModel.gender.value, forKey: "gender")
        
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
        
        UserDefaults.standard.set(genderViewModel.gender.value, forKey: "gender")
        
    }
    
    @objc func nextButtonClicked() {
        APIService.shared.signInUser(idToken: UserDefaults.standard.object(forKey: "idToken") as? String ?? "") { code, json in
            
            switch code {
            case 200:
                print("회원가입 성공")
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
                
            case 201:
                print("이미가입 유저")
                
            case 202:
                print("사용할수 없는 닉네임")
                // to NicknameViewController
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
            case 401:
                print("firebase token error")
                
            case 500:
                print("server Error")
                
            case 501:
                print("client error")
                
            default:
                print("default error")
                
            }
            
        }
    }
       
    
}
