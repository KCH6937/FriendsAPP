//
//  HomeViewController.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        removeUserDefaultsData()
    }
    
    func removeUserDefaultsData() {
        UserDefaults.standard.removeObject(forKey: "nick")
        UserDefaults.standard.removeObject(forKey: "birth")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "gender")
    }
    
}
