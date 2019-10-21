//
//  FavoritesVC.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    
        lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            let FavoriteView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
            
            FavoriteView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "favCell")
//            FavoriteView.delegate = self
//            FavoriteView.dataSource = self
            FavoriteView.backgroundColor = .red
            
            return FavoriteView
            
        }()

    private func configureCollectionView(){
        collectionView.addSubview(collectionView)
       collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
      collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200).isActive = true
       collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
    }
    
    
            override func viewDidLoad() {
                super.viewDidLoad()
                view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                addSubView()
                configureCollectionView()
               

            }
    

    
        func addSubView() {
              self.view.addSubview(collectionView)
            
             
          }
        
    }

    extension ViewController: UICollectionViewDelegate {
        
    }

    extension ViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            return UICollectionViewCell()
        }
        
        
    }

    extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

}
