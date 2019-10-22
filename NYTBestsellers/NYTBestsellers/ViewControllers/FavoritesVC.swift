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
    
    fvc.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
            override func viewDidLoad() {
                super.viewDidLoad()
                view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
                addSubView()
                configureCollectionView()
                loadFavs()
                setNeedsStatusBarAppearanceUpdate()
            }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadFavs()
        setNeedsStatusBarAppearanceUpdate()
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
            cell.actionButton.tag = indexPath.row
            cell.delegate = self
            return cell
        }
        
        
    }
extension FavoritesVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: FVCollectionView.frame.width, height: 500)
    }
    
}

extension FavoritesVC: FavDelegate {
func showActionSheet(tag: Int) {
    
let optionsMenu = UIAlertController.init(title: "Options", message: "Make Selection", preferredStyle: .actionSheet)

let shareAction = UIAlertAction.init(title: "Share", style: .default) { (action) in
    let image = UIImage(data: self.favs[tag].image)
    let share = UIActivityViewController(activityItems: [image!], applicationActivities: [])
    self.present(share, animated: true, completion: nil)
}

let deleteAction = UIAlertAction.init(title: "Delete", style: .destructive) { (action) in
let pic = self.favs[tag]
    print("deleting \(pic.bookDetails?[0].title ?? "")")
do {
    try FavPersistenceHelper.manager.delete(index: tag)
    self.loadFavs()
} catch {
    return
}
}
    
let amazonAction = UIAlertAction.init(title: "See On Amazon", style: .default) { (action) in
    let pic = self.favs[tag]
    UIApplication.shared.open(URL(string: pic.amazonProductURL ?? "amazon.com")!, options: [:], completionHandler: nil)

    
}

let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
optionsMenu.addAction(amazonAction)
optionsMenu.addAction(shareAction)
optionsMenu.addAction(deleteAction)
optionsMenu.addAction(cancelAction)
present(optionsMenu,animated: true,completion: nil)


}

}

