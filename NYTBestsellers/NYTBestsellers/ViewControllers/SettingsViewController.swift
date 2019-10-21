//
//  SettingsViewController.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK: - UIObjects
    var pickerView = Picker()
    var categories = [Hit]() {
        didSet {
            self.pickerView.reloadAllComponents()
        }
    }
    

    //MARK: - SetupFunctions
    private func setSettingsUI() {
        view.backgroundColor = .white
        setPickerConstraints()
    }
    func setupCategories() {
        categories = Picker.categories
    }
    private func setPickerConstraints() {
        view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            pickerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            pickerView.heightAnchor.constraint(equalToConstant: pickerView.frame.height)])
        view.layoutIfNeeded()
    }
    private func setPickerDelegates() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    private func loadPickerDefaults() {
        if let row = UserDefaultWrapper.manager.getCategoryRow() {
            pickerView.selectRow(row, inComponent: 0, animated: true)
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettingsUI()
        setPickerDelegates()
        setupCategories()
        loadPickerDefaults()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadPickerDefaults()
    }

}

//MARK: Extension
extension SettingsViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Picker.categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Picker.categories[row].displayName
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaultWrapper.manager.set(value: row)
        let name = categories[row].displayName.replacingOccurrences(of: " ", with: "-").lowercased()
        UserDefaultWrapper.manager.set(name: name)
        
    }
    
}
