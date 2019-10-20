//
//  BsCollectionViewCell.swift
//  NYTBestsellers
//
//  Created by hildy abreu on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class BsCollectionViewCell: UICollectionViewCell {
    
    var googleBookInfo: GoogleInfo? 
        
        lazy var BestsellerImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .blue
            return imageView
        }()
        
        lazy var NumberOfWeeksLabel: UILabel = {
            let weeksLabel = UILabel()
            weeksLabel.text = "placeHolder"
            weeksLabel.textAlignment = .center
            weeksLabel.textColor = .black
            return weeksLabel
        }()
        
        lazy var TextViewDescription: UITextView = {
            let textDescription = UITextView()
            textDescription.text = "Description"
            textDescription.textColor = .black
            textDescription.isScrollEnabled = true
            textDescription.isSelectable = false
            textDescription.isEditable = false
            
            return textDescription
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
     
         backgroundColor = .lightGray
            addSubview(NumberOfWeeksLabel)
            addSubview(TextViewDescription)
            setImageConstraints()
            setLabelConstraint()
            setTextViewConstraint()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setImageConstraints() {
             addSubview(BestsellerImageView)
            BestsellerImageView.translatesAutoresizingMaskIntoConstraints = false
            BestsellerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
            BestsellerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100).isActive = true
            BestsellerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100).isActive = true
            BestsellerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150).isActive = true
        }
        
        func setLabelConstraint() {
            addSubview(NumberOfWeeksLabel)
            NumberOfWeeksLabel.translatesAutoresizingMaskIntoConstraints = false
            NumberOfWeeksLabel.topAnchor.constraint(equalTo: BestsellerImageView.bottomAnchor, constant: 11).isActive = true
            NumberOfWeeksLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            NumberOfWeeksLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }
        
        func setTextViewConstraint() {
            addSubview(TextViewDescription)
            TextViewDescription.translatesAutoresizingMaskIntoConstraints = false
            TextViewDescription.topAnchor.constraint(equalTo: NumberOfWeeksLabel.bottomAnchor, constant: 2).isActive = true
            TextViewDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            TextViewDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0).isActive = true
            TextViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            
        }
    
    
}

