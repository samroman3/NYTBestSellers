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
    
    private var books = [BS]() {
              didSet {
                  DispatchQueue.main.async {
                      self.BSCollectionView.reloadData()
                  }
              }
          }
    
   
    
    
    
    private var pickerView = Picker() {
        didSet {
            BSCollectionView.reloadData()
        }
    }
    
    private var categories = Picker.categories {
        didSet {
            print(categories)
            pickerView.reloadAllComponents()
        }
    }
    
    var category = Picker.category {
        didSet {
            loadBestSellers()
            BSCollectionView.reloadData()
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
        view.addSubview(BSCollectionView)
        BSCollectionView.translatesAutoresizingMaskIntoConstraints = false
        BSCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        BSCollectionView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        BSCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200).isActive = true
        BSCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
    }
    private func configurePickerConstraints() {
        view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: BSCollectionView.bottomAnchor, constant: 10),
            pickerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            pickerView.heightAnchor.constraint(equalToConstant: pickerView.frame.height)])
        view.layoutIfNeeded()
    }

    
      private func setPickerDelegates() {
          pickerView.delegate = self
          pickerView.dataSource = self
      }
    
    private func setUpPicker() {
        setPickerDelegates()
        configurePickerConstraints()
    }
    func setupCategories() {
        categories = Picker.categories
    }
    
    //MARK: Private Data Methods
    private func loadBestSellers(){
        NYTAPIClient.shared.getBookInfo(category: category) { (result) in
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

    
    private func loadCategories(){
        NYTAPIClient.shared.getCategory { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("unable to load category due to \(error)")
                case .success(let data):
                    self.categories = data.results!
                    print("succesfully loaded categories")
                }
            }
        }
    }
    private func loadPickerDefaults() {
        if let row = UserDefaultWrapper.manager.getCategoryRow(),let name = UserDefaultWrapper.manager.getCategoryName() {
            pickerView.selectRow(row, inComponent: 0, animated: true)
            category = name
        }
    }
   
       

    
       
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
        setUpPicker()
        loadCategories()
        loadBestSellers()

    }
    override func viewWillAppear(_ animated: Bool) {
        loadPickerDefaults()
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
                    guard let small = info.items?[0].volumeInfo?.imageLinks?.smallThumbnail else { cell.BestsellerImageView.image = UIImage(named: "default-book")
                        return
                    }
                    ImageHelper.shared.fetchImage(urlString: (small)) { (result) in
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
    //MARK: CollectionView Delegate Flow Layout Extension
extension BestSellersVC: UICollectionViewDelegateFlowLayout{
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: BSCollectionView.frame.width, height: BSCollectionView.frame.height)
    }
    
}


    //MARK: UIPickerView Extension
extension BestSellersVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].displayName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       //TODO: Create Array of all listnames in Category data
        let name = categories[row].displayName.replacingOccurrences(of: " ", with: "-").lowercased()
        category = name
        
    }
    
}
