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
          return titletextLabel
      }()
    
    
    
    private func setTextConstrains() {
         textLabel.translatesAutoresizingMaskIntoConstraints = false
         [textLabel.centerXAnchor.constraint(equalTo: centerXAnchor), textLabel.centerYAnchor.constraint(equalTo: centerYAnchor), ].forEach{ $0.isActive = true }
     }
     
//    lazy var actionButton: UIButton = {
//        let actionSheetButton = UIButton()
//        self.addSubview(actionSheetButton)
//        return actionSheetButton
//    }()
//
//
    
        lazy var TextViewDescription: UITextView = {
              let TextDescription = UITextView()
              TextDescription.text = "Description"
            TextDescription.textColor = .black
              TextDescription.font = .italicSystemFont(ofSize: 16)
              TextDescription.isScrollEnabled = true
              TextDescription.isSelectable = false
              TextDescription.isEditable = false
              
              return TextDescription
          }()
    
    func setTextViewConstraint() {
         TextViewDescription.translatesAutoresizingMaskIntoConstraints = false
         
         TextViewDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
         TextViewDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -0).isActive = true
         TextViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
         
     }
    
    
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        addSubview(textLabel)
        addSubview(TextViewDescription)
        setTextConstrains()
        setTextViewConstraint()
        self.translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    }

    

