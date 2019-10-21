//
//  DetailVC.swift
//  NYTBestsellers
//
//  Created by hildy abreu on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    var googleInfo: GoogleInfo?
    var BS: BS?
    
    lazy var bookImageView: UIImageView = {
        let pic = UIImageView()
        pic.clipsToBounds = true
        pic.contentMode = .scaleAspectFill
        pic.alpha = 0.7
        return pic
    } ()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name:"Optima-BOld", size: 22)
        return label
    }()
    lazy var bookTextView: UITextView = {
        let summary = UITextView()
        summary.textAlignment = .left
        summary.textColor = .black
        summary.font = UIFont(name:"system", size: 14)
        return summary
    }()
    
    lazy var favButton: UIBarButtonItem = {
        let fav = UIBarButtonItem(barButtonSystemItem: .save , target: self, action: #selector(favButtonPressed(sender:)))
        self.navigationItem.rightBarButtonItem = fav
        return fav
    }()
        

    @objc func favButtonPressed(sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    private func configureBookImageViewConstraints() {
//        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bookImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10), bookImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor), bookImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor), bookImageView.heightAnchor.constraint(equalToConstant: 350)])
        }

    private func configureAuthorLabelConstraints() {
//        addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([authorLabel.centerXAnchor.constraint(equalTo: bookImageView.centerXAnchor), authorLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10), authorLabel.heightAnchor.constraint(equalToConstant: 30)])
        }
    
    private func configureBookTextViewConstraints(){
//        addSubview(bookTextView)
        
        bookTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
        [bookTextView.centerXAnchor.constraint(equalTo:
        authorLabel.centerXAnchor),
        bookTextView.topAnchor.constraint(equalTo:
        authorLabel.bottomAnchor, constant: 10), bookTextView.heightAnchor.constraint(equalToConstant: 450)])
    }
    
    
    
}
