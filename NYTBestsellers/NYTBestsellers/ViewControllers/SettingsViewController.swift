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
    var categories = [String]() {
        didSet {
            self.pickerView.reloadAllComponents()
        }
    }
    
    lazy var selectCategoryLabel: UILabel = {
        var label = UILabel()
        label.text = "Select Category:"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name:"Optima-BOld", size: 24)
        return label
    }()
    
    //MARK: - SetupFunctions
    private func setSettingsUI() {
        view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        setPickerConstraints()
        setCategoryLabelConstraints()
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
    
    private func setCategoryLabelConstraints(){
        view.addSubview(selectCategoryLabel)
        NSLayoutConstraint.activate([
            selectCategoryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            selectCategoryLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            selectCategoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectCategoryLabel.heightAnchor.constraint(equalToConstant: 40)])
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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettingsUI()
        setPickerDelegates()
        setupCategories()
        loadPickerDefaults()
        setNeedsStatusBarAppearanceUpdate()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadPickerDefaults()
         view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        setNeedsStatusBarAppearanceUpdate()
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(categories[row]), attributes: [NSAttributedString.Key.foregroundColor: UIColor.white ])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaultWrapper.manager.set(value: row)
        let name = categories[row].replacingOccurrences(of: " ", with: "-").lowercased()
        UserDefaultWrapper.manager.set(name: name)
        
    }
    
}
