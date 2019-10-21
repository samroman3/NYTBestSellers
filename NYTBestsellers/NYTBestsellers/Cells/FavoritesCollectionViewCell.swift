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
               imageView.backgroundColor = .blue
               return imageView
           }()
    
    
     
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
            TextDescription.backgroundColor = .lightGray
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
        BestsellerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        BestsellerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
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
        TextViewDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
    }
  
    
    
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        addSubview(BestsellerImageView)
        addSubview(textLabel)
        addSubview(TextViewDescription)
        setImageConstraints()
        setLabelConstraint()
        setTextViewConstraint()
        self.translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    }

    

