//
//  FavoritesVC.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
    var favs = [Favorite]() {
        
        didSet {
            DispatchQueue.main.async {
                self.FVCollectionView.reloadData()
            }
        }
    }
    
    
    
    lazy var FVCollectionView: UICollectionView = {
        let fvc = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        if let layout = fvc.collectionViewLayout as? UICollectionViewFlowLayout {
        layout.scrollDirection = .vertical
        }
    
    fvc.backgroundColor = .black
    fvc.delegate = self
    fvc.dataSource = self
    fvc.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "favCell")
    return fvc
    }()
    
    
    private func configureCollectionView(){
        FVCollectionView.translatesAutoresizingMaskIntoConstraints = false
        FVCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        FVCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: 0).isActive = true
      FVCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
       FVCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        view.layoutIfNeeded()
    }
    
    
            override func viewDidLoad() {
                super.viewDidLoad()
                view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                addSubView()
                configureCollectionView()
                loadFavs()
            }
    
    
        func addSubView() {
              view.addSubview(FVCollectionView)
            
             
          }
    
    private func loadFavs(){
        do {
            let getfavs = try FavPersistenceHelper.manager.getPhoto()
            favs = getfavs
        } catch {
            return
        }
    }
        
    }



    extension FavoritesVC: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return favs.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = FVCollectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavoritesCollectionViewCell else { return UICollectionViewCell() }
           let favorite = favs[indexPath.row]
            cell.textLabel.text = favorite.bookDetails?[0].author
            cell.TextViewDescription.text = favorite.bookDetails?[0].bookDetailDescription
            cell.BestsellerImageView.image = UIImage(data: favorite.image)
            return cell
        }
        
        
    }
extension FavoritesVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: FVCollectionView.frame.width, height: FVCollectionView.frame.height)
    }
    
}
