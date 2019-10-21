//
//  Picker.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class Picker: UIPickerView {
    var categories = [Hit]() {
        didSet {
            self.reloadAllComponents()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2
        layer.borderColor = UIColor.purple.cgColor
        layer.cornerRadius = 30
        setPickerDelegates()
        loadCatagories()
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
                if let hits = categoriesFromJSON.results {
                    self.categories = hits
                }
            }
        }
    }
    private func setPickerDelegates() {
        delegate = self
        dataSource = self
    }
}

//MARK: Extension
extension Picker: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].displayName
    }
    
}
