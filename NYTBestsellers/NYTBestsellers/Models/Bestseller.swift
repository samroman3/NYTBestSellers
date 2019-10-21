//
//  Bestseller.swift
//  NYTBestsellers
//
//  Created by Sam Roman on 10/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation



// MARK: - BestSellers
struct BestSellers: Codable {
    let status, copyright: String?
    let numResults: Int?
    let results: [BS]?
    
    static func getBestSellersFromData(data: Data) throws -> BestSellers? {
    do {
        let info = try JSONDecoder().decode(BestSellers.self, from: data)
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
struct BS: Codable {
    let listName: String?
    let displayName: String?
    let bestsellersDate, publishedDate: String?
    let rank, rankLastWeek, weeksOnList, asterisk: Int?
    let dagger: Int?
    let amazonProductURL: String?
    let isbns: [Isbn]?
    let bookDetails: [BookDetail]?
    let reviews: [Review]?

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case rank
        case rankLastWeek = "rank_last_week"
        case weeksOnList = "weeks_on_list"
        case asterisk, dagger
        case amazonProductURL = "amazon_product_url"
        case isbns
        case bookDetails = "book_details"
        case reviews
    }
}

// MARK: - BookDetail
struct BookDetail: Codable {
    let title, bookDetailDescription, contributor, author: String?
    let contributorNote: String?
    let price: Int?
    let ageGroup, publisher, primaryIsbn13, primaryIsbn10: String?

    enum CodingKeys: String, CodingKey {
        case title
        case bookDetailDescription = "description"
        case contributor, author
        case contributorNote = "contributor_note"
        case price
        case ageGroup = "age_group"
        case publisher
        case primaryIsbn13 = "primary_isbn13"
        case primaryIsbn10 = "primary_isbn10"
    }
}



// MARK: - Isbn
struct Isbn: Codable {
    let isbn10, isbn13: String?
}

// MARK: - Review
struct Review: Codable {
    let bookReviewLink: String?
    let firstChapterLink, sundayReviewLink, articleChapterLink: String?

    enum CodingKeys: String, CodingKey {
        case bookReviewLink = "book_review_link"
        case firstChapterLink = "first_chapter_link"
        case sundayReviewLink = "sunday_review_link"
        case articleChapterLink = "article_chapter_link"
    }
}


let backUpBestSellers = BestSellers(status: "ok", copyright: "200", numResults: 1, results: [BS(listName: "", displayName: "", bestsellersDate: "", publishedDate: "", rank: 0, rankLastWeek: 0, weeksOnList: 0, asterisk: 0, dagger: 0, amazonProductURL: "", isbns: nil , bookDetails: [BookDetail(title: "", bookDetailDescription: "No Titles Available", contributor: "", author: "", contributorNote: "", price: nil, ageGroup: "", publisher: "", primaryIsbn13: nil, primaryIsbn10: nil )], reviews: [Review(bookReviewLink: "", firstChapterLink: "", sundayReviewLink: "", articleChapterLink: "")])])
