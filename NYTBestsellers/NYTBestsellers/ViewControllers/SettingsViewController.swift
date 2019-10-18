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
    var sample = ["testOne","testTwo","testThree","testFour"]

    //MARK: - SetupFunctions
    private func setSettingsUI() {
        view.backgroundColor = .white
        setPickerDelegates()
        setPickerConstraints()
    }
    private func setPickerDelegates() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    private func setPickerConstraints() {
        view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            pickerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            pickerView.heightAnchor.constraint(equalToConstant: pickerView.frame.height)])
        view.layoutIfNeeded()
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettingsUI()
    }
    

}

//MARK: Extension
extension SettingsViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sample.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sample[row]
    }
    
}
