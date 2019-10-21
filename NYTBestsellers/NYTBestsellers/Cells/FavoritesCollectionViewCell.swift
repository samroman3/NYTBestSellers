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
          let textLabel = UILabel()
          self.addSubview(textLabel)
          return textLabel
      }()
    
    private func setTextConstrains() {
         textLabel.translatesAutoresizingMaskIntoConstraints = false
         [textLabel.centerXAnchor.constraint(equalTo: centerXAnchor), textLabel.centerYAnchor.constraint(equalTo: centerYAnchor), ].forEach{ $0.isActive = true }
     }
     
    
    
    
        lazy var TextViewDescription: UITextView = {
              let textDescription = UITextView()
              textDescription.text = "Description"
            textDescription.textColor = .gray
              textDescription.font = .italicSystemFont(ofSize: 16)
              textDescription.isScrollEnabled = true
              textDescription.isSelectable = false
              textDescription.isEditable = false
              
              return textDescription
          }()
    
    func setTextViewConstraint() {
         addSubview(TextViewDescription)
         TextViewDescription.translatesAutoresizingMaskIntoConstraints = false
         
         TextViewDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
         TextViewDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0).isActive = true
         TextViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
         
     }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
       setTextConstrains()
        setTextViewConstraint()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    }

    

