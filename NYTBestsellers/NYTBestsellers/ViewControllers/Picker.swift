//
//  Picker.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class Picker: UIPickerView {
    static var categories = [String]()
    static var category = "Hardcover-nonfiction"

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2
        layer.borderColor = UIColor.purple.cgColor
        layer.cornerRadius = 30
        setCategoriesDefaults()
        print(Picker.categories)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func loadCatagories() {
        NYTAPIClient.shared.getCategory { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let categoriesFromJSON):
                DispatchQueue.main.async {
                    Picker.categories = categoriesFromJSON
                }
            }
        }
    }
    func setCategoriesDefaults() {
        if let categories = UserDefaultWrapper.manager.getCategories() {
            Picker.categories = categories
        } else {
            loadCatagories()
        }
    }
}


