//
//  FavPersistance.swift
//  NYTBestsellers
//
//  Created by Angela Garrovillas on 10/21/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct FavPersistenceHelper {
    
    private static var pictures = [Favorite]()
    
    static let manager = FavPersistenceHelper()
    func save(newPhoto: Favorite) throws {
        try persistenceHelper.save(newElement: newPhoto)
    }
    func getPhoto() throws -> [Favorite] {
        return try persistenceHelper.getObjects()
    }
    
//    func editPhoto(element: Favorite, index: Int) throws {
//        return try persistenceHelper.editAtIndex(editedElement: element, index: index)
//    }
    
    //TODO: find way to delete picture based on sender tag in collectionview cell
    func delete(index: Int) throws {
        return try persistenceHelper.deleteAtIndex(index: index)
        
}
    
    private let persistenceHelper = PersistenceHelper<Favorite>(fileName: "favBooks.plist")
    private init() {}
}
