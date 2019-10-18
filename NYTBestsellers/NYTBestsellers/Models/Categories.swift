
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let status, copyright: String?
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
        case status, copyright
        case numResults = "num_results"
        case results
    }
}

// MARK: - Result
struct Hit: Codable {
    let listName, displayName, listNameEncoded, oldestPublishedDate: String?
    let newestPublishedDate: String?
    let updated: Updated?
    
    

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
        case updated
        
    }
}

enum Updated: String, Codable {
    case monthly = "MONTHLY"
    case weekly = "WEEKLY"
}
