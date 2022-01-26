//
//  Observable.swift
//  FriendsApp
//
//  Created by 강채현 on 2022/01/22.
//

import Foundation

class Observable<T> {
    private var listner: ((T) -> Void)?
  
    var value: T {
        didSet {
            listner?(value)
        }
    }
  
    init(_ value: T) {
        self.value = value
    }
  
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listner = closure
    }
}

