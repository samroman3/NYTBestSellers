//
//  UserDefaultWrapper.swift
//  NYTBestsellers
//
//  Created by Angela Garrovillas on 10/21/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation
class UserDefaultWrapper {
    
    private init () {}
    
    static let manager = UserDefaultWrapper()
    
    //MARK: Keys
    private let categoryRowKey = "category"
    private let categoryNameKey = "name"
    
    
    //MARK: Sets
    func set(value: Int) {
        print("saved: \(value)")
        UserDefaults.standard.set(value, forKey: categoryRowKey)
    }
    func set(name: String) {
        UserDefaults.standard.set(name, forKey: categoryNameKey)
    }
    
    //MARK: Gets
    func getCategoryRow() -> Int? {
        if let row = UserDefaults.standard.value(forKey: categoryRowKey) as? Int {
            return row
        }
        return nil
    }
    func getCategoryName() -> String? {
        if let name = UserDefaults.standard.value(forKey: categoryNameKey) as? String {
            return name
        }
        return nil
    }
    
}
