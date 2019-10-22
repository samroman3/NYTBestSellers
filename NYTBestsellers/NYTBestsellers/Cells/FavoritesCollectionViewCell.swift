//
//  FavoritesCollectionViewCell.swift
//  NYTBestsellers
//
//  Created by hildy abreu on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    lazy var textLabel: UILabel = {
        let titletextLabel = UILabel()
        titletextLabel.backgroundColor = .white
        titletextLabel.font = UIFont(name:"Optima-BOld", size: 24)
        titletextLabel.textAlignment = .center
        return titletextLabel
    }()
    
    lazy var BestsellerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    weak var delegate: FavDelegate?
    
    
    @objc func favMenuAction(_ sender: UIButton) {
        delegate?.showActionSheet(tag: sender.tag)
    }
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(.actions, for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(favMenuAction(_:)), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var TextViewDescription: UITextView = {
        let TextDescription = UITextView()
        TextDescription.text = "Description"
        TextDescription.textColor = .black
        TextDescription.backgroundColor = UIColor(white: 0.97, alpha: 1)
        TextDescription.font = .italicSystemFont(ofSize: 16)
        TextDescription.textAlignment = .center
        TextDescription.font = TextDescription.font?.withSize(21)
        TextDescription.isScrollEnabled = true
        TextDescription.isSelectable = false
        TextDescription.isEditable = false
        
        return TextDescription
    }()
    
    func setImageConstraints() {
        BestsellerImageView.translatesAutoresizingMaskIntoConstraints = false
        BestsellerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        BestsellerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -80).isActive = true
        BestsellerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 80).isActive = true
        BestsellerImageView.bottomAnchor.constraint(equalTo: self.centerYAnchor , constant: 100).isActive = true
    }
    
    func setLabelConstraint() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: BestsellerImageView.bottomAnchor, constant: 11).isActive = true
        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    func setTextViewConstraint() {
        TextViewDescription.translatesAutoresizingMaskIntoConstraints = false
        TextViewDescription.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 2).isActive = true
        TextViewDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        TextViewDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0).isActive = true
        TextViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
    }
    
    func setActionSheetConstraint(){
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.topAnchor.constraint(equalTo: topAnchor , constant: 10).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(BestsellerImageView)
        addSubview(textLabel)
        addSubview(TextViewDescription)
        addSubview(actionButton)
        setImageConstraints()
        setLabelConstraint()
        setTextViewConstraint()
        setActionSheetConstraint()
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



