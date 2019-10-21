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
    

    //MARK: - SetupFunctions
    private func setSettingsUI() {
        view.backgroundColor = .white
        setPickerConstraints()
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


