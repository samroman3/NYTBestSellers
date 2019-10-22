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
    var BS: BS? {
        didSet {
            loadData()
        }
    }
    
    lazy var bookImageView: UIImageView = {
        let pic = UIImageView()
        pic.clipsToBounds = true
        pic.contentMode = .scaleAspectFit
        pic.alpha = 1
        pic.backgroundColor = UIColor(white: 0.98, alpha: 1)
        return pic
    } ()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name:"Optima-BOld", size: 24)
        return label
        
    }()
    
    lazy var bookTextView: UITextView = {
        let summary = UITextView()
        summary.textAlignment = .center
        summary.textColor = .black
        summary.text = "Description Unavailable"
        summary.font = summary.font?.withSize(20)
        return summary
    }()
    
    lazy var amazonButton: UIButton = {
        let amazon = UIButton()
        amazon.setImage(UIImage(named: "amazon-icon"), for: .normal)
        amazon.isHidden = false
        amazon.contentMode = .scaleAspectFit
        amazon.backgroundColor = .white
        amazon.isUserInteractionEnabled = true
        amazon.isEnabled = true
        amazon.addTarget(self, action: #selector(didTapAmazon(sender:)), for: UIControl.Event.touchUpInside)
        return amazon
    }()
    
    @objc func didTapAmazon(sender: UIButton) {
        UIApplication.shared.open(URL(string:BS?.amazonProductURL ?? "amazon.com")!, options: [:], completionHandler: nil)
    }
    
    lazy var favButton: UIBarButtonItem = {
        let fav = UIBarButtonItem(barButtonSystemItem: .save , target: self, action: #selector(favButtonPressed(sender:)))
        return fav
    }()
        

    @objc func favButtonPressed(sender: UIBarButtonItem) {
       do {
                guard let cover = bookImageView.image?.pngData() else { return  }
                let fav = Favorite(bookDetails: BS?.bookDetails, isbns: BS?.isbns, amazonProductURL: BS?.amazonProductURL, imageLink: googleInfo?.items?[0].volumeInfo?.imageLinks, image: cover)
                 try FavPersistenceHelper.manager.save(newPhoto: fav)
            } catch {
                return
            }
        navigationController?.popViewController(animated: true)
           
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureAmazonButtonConstraints()
        configureBookImageViewConstraints()
        configureAuthorLabelConstraints()
        configureBookTextViewConstraints()
        self.navigationItem.rightBarButtonItem = favButton
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

       
    
    
    private func loadData(){
        authorLabel.text = BS?.bookDetails?[0].author
        bookTextView.text = BS?.bookDetails?[0].bookDetailDescription
        GoogleAPIClient.shared.getBookInfo(isbn: BS?.isbns?[0].isbn13) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.bookImageView.image = UIImage(named: "default-book")
                case .success(let pic):
                    let info = pic
                    guard let small = info.items?[0].volumeInfo?.imageLinks?.smallThumbnail else { self.bookImageView.image = UIImage(named: "default-book")
                                          return
                                      }
                                      ImageHelper.shared.fetchImage(urlString: (small)) { (result) in
                                          DispatchQueue.main.async {
                                              switch result {
                                              case .failure(let error):
                                                  print(error)
                                              case .success(let image):
                                                  print("Succesfully loading image for detailview")
                                                  self.bookImageView.image = image
                                              }
                                          }
                                      }
                }
            }
        }
    }
    private func configureBookImageViewConstraints() {
        view.addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bookImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10), bookImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 80), bookImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80), bookImageView.heightAnchor.constraint(equalToConstant: 350)])
        }

    private func configureAuthorLabelConstraints() {
        view.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([authorLabel.centerXAnchor.constraint(equalTo: bookImageView.centerXAnchor), authorLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10), authorLabel.heightAnchor.constraint(equalToConstant: 100),
                                     authorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0)
        ])
        }
    
    private func configureBookTextViewConstraints(){
        view.addSubview(bookTextView)
        
        bookTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
        [bookTextView.centerXAnchor.constraint(equalTo:
        authorLabel.centerXAnchor),
        bookTextView.topAnchor.constraint(equalTo:
        authorLabel.bottomAnchor, constant: 20), bookTextView.heightAnchor.constraint(equalToConstant: 450),
        bookTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0)])
        
    }
    
    private func configureAmazonButtonConstraints() {
        view.addSubview(amazonButton)
        amazonButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([amazonButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            amazonButton.widthAnchor.constraint(equalToConstant: 80),
            amazonButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), amazonButton.heightAnchor.constraint(equalToConstant: 80)])
    }
    
    
}
