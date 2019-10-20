//
//  BestSellersVC.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class BestSellersVC: UIViewController {
    
    
    //MARK: Private Data Variables
    var itemSize = CGSize(width: 250, height: 350)
    let cellSpacing = UIScreen.main.bounds.size.width * 0.09
    
    private var books = [BS]() {
              didSet {
                  DispatchQueue.main.async {
                      self.BSCollectionView.reloadData()
                  }
              }
          }
    
    var category = "hardcover-nonfiction" {
              didSet {
                  loadBestSellers()
              }
          }
    
       
    
    
    //MARK: UI Variables
    lazy var BSCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    cv.delegate = self
    cv.dataSource = self 
    cv.register(BsCollectionViewCell.self, forCellWithReuseIdentifier: "bsCell")
    return cv
    }()
    
    
    
    //MARK: Constraint Methods
    private func configureCollectionView(){
        BSCollectionView.translatesAutoresizingMaskIntoConstraints = false
        BSCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        BSCollectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        BSCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200).isActive = true
        BSCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        
    }
    
    //MARK: Private Data Methods
    private func loadBestSellers(){
        NYTAPIClient.shared.getBookInfo(category: self.category) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let bs):
                    self.books = bs.results!
                    print("succesfully loaded bestsellers")
                }
            }
        }
    }

    
   
       

    
       
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(BSCollectionView)
        view.backgroundColor = .darkGray
        configureCollectionView()
        loadBestSellers()
    }

}




    //MARK: CollectionView Extension
extension BestSellersVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = BSCollectionView.dequeueReusableCell(withReuseIdentifier: "bsCell", for: indexPath) as? BsCollectionViewCell else { return UICollectionViewCell() }
               let book = books[indexPath.row]
        cell.NumberOfWeeksLabel.text = "\(book.weeksOnList ?? 0) week(s) on best sellers list"
        cell.TextViewDescription.text = book.bookDetails?.first?.bookDetailDescription
        GoogleAPIClient.shared.getBookInfo(isbn: book.isbns?.first?.isbn13) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let info):
                    cell.googleBookInfo = info
                    let small = info.items![0].volumeInfo?.imageLinks?.smallThumbnail
                    ImageHelper.shared.fetchImage(urlString: (small ?? "9780316535625")) { (result) in
                        DispatchQueue.main.async {
                            switch result {
                            case .failure(let error):
                                print(error)
                            case .success(let image):
                                print("Succesfully loading image for cell")
                                cell.BestsellerImageView.image = image
                            }
                        }
                    }
                }
            }
        }
        return cell
    }
    
    
}

extension BestSellersVC: UICollectionViewDelegateFlowLayout{
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: BSCollectionView.frame.width, height: BSCollectionView.frame.height)
    }
    
    

    
}
