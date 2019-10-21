//
//  Favorites.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct Favorite: Codable {
     let bookDetails: [BookDetail]?
     let isbns: [Isbn]?
     let amazonProductURL: String?
     let imageLink: ImageLinks?
     let image: Data
}
