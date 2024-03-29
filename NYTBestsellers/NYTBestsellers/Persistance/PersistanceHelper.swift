//
//  PersistanceHelper.swift
//  NYTBestsellers
//
//  Created by Angela Garrovillas on 10/21/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

struct PersistenceHelper<T: Codable> {
    
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    
    func deleteAtIndex(index: Int) throws {
        var elements = try getObjects()
        elements.remove(at: index)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func save(newElement: T) throws {
        var elements = try getObjects()
        var new = [newElement]
        new.append(contentsOf: elements)
        let serializedData = try PropertyListEncoder().encode(new)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func editAtIndex(editedElement: T, index: Int) throws {
        var elements = try getObjects()
        elements[index] = editedElement
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    private func filePathFromDocumentsDirectory(name: String) -> URL {
        return documentsDirectory.appendingPathComponent(name)
    }
    
    private let fileName: String
    
    private var url: URL {
        return filePathFromDocumentsDirectory(name: fileName)
    }
}
