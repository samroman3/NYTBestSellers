//
//  BestSellerAPIClient.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct NYTAPIClient {
    private init() {}
    static let shared = NYTAPIClient()
    
    func getBookInfo(category: String , completionHandler: @escaping (Result<BestSellers, AppError>) -> ()) {
        let urlStr = "https://api.nytimes.com/svc/books/v3/lists.json?api-key=\(Secrets.nytimeskey)&list=\(category)"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                
                do {
                   let bestsellers = try BestSellers.getBestSellersFromData(data: data)
                    completionHandler(.success(bestsellers ?? backUpBestSellers))
                }
                catch {
                    completionHandler(.success(backUpBestSellers))
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
    }
    
    func getCategory(completionHandler: @escaping (Result<Categories, AppError>) -> ()) {
        let urlStr = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(Secrets.nytimeskey)"
        
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(AppError.badURL))
            return
        }
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(.other(rawError: error)))
            case .success(let data):
                
                do {
                    let categories = try Categories.getCategoriesFromData (data: data)
                    completionHandler(.success(categories!))
                }
                catch {
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
    }
    
    
    
    
}


