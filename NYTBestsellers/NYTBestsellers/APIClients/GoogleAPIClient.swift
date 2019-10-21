//
//  GoogleAPIClient.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct GoogleAPIClient {
    private init() {}
    static let shared = GoogleAPIClient()
    
    func getBookInfo(isbn: String? , completionHandler: @escaping (Result<GoogleInfo, AppError>) -> ()) {
        let urlStr = "https://www.googleapis.com/books/v1/volumes?q=+isbn:\(isbn ?? "")&key=\(Secrets.googlekey)"
        
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
                    let bookinfo = try GoogleInfo.getInfoFromData(data: data)
                    completionHandler(.success(bookinfo!))
                }
                catch {
                    completionHandler(.failure(.other(rawError: error)))
                }
            }
        }
    }
    
}
