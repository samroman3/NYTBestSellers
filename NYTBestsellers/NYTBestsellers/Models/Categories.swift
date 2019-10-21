
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let numResults: Int?
    let results: [Hit]?
    
    static func getCategoriesFromData(data: Data) throws -> Categories? {
        do {
            let info = try JSONDecoder().decode(Categories.self, from: data)
            return info

        } catch {
            print(error)
            return nil
        }

    }

    enum CodingKeys: String, CodingKey {
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
struct Hit: Codable {
    let listName: String
    let displayName: String
    let newestPublishedDate: String?
  
    
    

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case newestPublishedDate = "newest_published_date"
        
    }
}
