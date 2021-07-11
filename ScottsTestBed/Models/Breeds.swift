//
//  Breeds.swift
//  ScottsTestBed
//
//  Created by Scott Kriss on 7/8/21.
//

import UIKit
import Foundation

class Breeds: Codable {
    
    let currentPage: Int
    let data: [Data]
    let firstPageUrl: String
    let from: Int
    let lastPage: Int
    let lastPageUrl: String
    let links: [Links]
    let nextPageUrl: String
    let path: String
    let perPage: Int
    let prevPageUrl: String?
    let to: Int
    let total: Int
    
    private enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data = "data"
        case firstPageUrl = "first_page_url"
        case from = "from"
        case lastPage = "last_page"
        case lastPageUrl = "last_page_url"
        case links = "links"
        case nextPageUrl = "next_page_url"
        case path = "path"
        case perPage = "per_page"
        case prevPageUrl = "prev_page_url"
        case to = "to"
        case total = "total"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currentPage = try values.decode(Int.self, forKey: .currentPage)
        data = try values.decode([Data].self, forKey: .data)
        firstPageUrl = try values.decode(String.self, forKey: .firstPageUrl)
        from = try values.decode(Int.self, forKey: .from)
        lastPage = try values.decode(Int.self, forKey: .lastPage)
        lastPageUrl = try values.decode(String.self, forKey: .lastPageUrl)
        links = try values.decode([Links].self, forKey: .links)
        nextPageUrl = try values.decode(String.self, forKey: .nextPageUrl)
        path = try values.decode(String.self, forKey: .path)
        perPage = try values.decode(Int.self, forKey: .perPage)
        prevPageUrl = try values.decodeIfPresent(String.self, forKey: .prevPageUrl)
        to = try values.decode(Int.self, forKey: .to)
        total = try values.decode(Int.self, forKey: .total)
    }
    
}

//struct Data: Codable {
//
//    let breed: String
//    let country: String
//    let origin: String
//    let coat: String
//    let pattern: String

//}

//struct Links: Codable {
//
//    let url: Any
//    let label: String
//    let active: Bool
//
//}

// MARK: - Breeds
//class Breeds: Codable {
//    let currentPage: Int
//    let data: [Data]
//    let firstPageURL: String
//    let from, lastPage: Int
//    let lastPageURL: String
//    let links: [Link]
//    let nextPageURL, path: String
//    let perPage: Int
//    let prevPageURL: JSONNull?
//    let to, total: Int
//
//    enum CodingKeys: String, CodingKey {
//        case currentPage = "current_page"
//        case data
//        case firstPageURL = "first_page_url"
//        case from
//        case lastPage = "last_page"
//        case lastPageURL = "last_page_url"
//        case links
//        case nextPageURL = "next_page_url"
//        case path
//        case perPage = "per_page"
//        case prevPageURL = "prev_page_url"
//        case to, total
//    }
//
//    init(currentPage: Int, data: [Data], firstPageURL: String, from: Int, lastPage: Int, lastPageURL: String, links: [Link], nextPageURL: String, path: String, perPage: Int, prevPageURL: JSONNull?, to: Int, total: Int) {
//        self.currentPage = currentPage
//        self.data = data
//        self.firstPageURL = firstPageURL
//        self.from = from
//        self.lastPage = lastPage
//        self.lastPageURL = lastPageURL
//        self.links = links
//        self.nextPageURL = nextPageURL
//        self.path = path
//        self.perPage = perPage
//        self.prevPageURL = prevPageURL
//        self.to = to
//        self.total = total
//    }
//}
//
//// MARK: - Data
//class Data: Codable {
//    let breed, country, origin, coat: String
//    let pattern: String
//
//    init(breed: String, country: String, origin: String, coat: String, pattern: String) {
//        self.breed = breed
//        self.country = country
//        self.origin = origin
//        self.coat = coat
//        self.pattern = pattern
//    }
//}
//
//// MARK: - Link
//class Link: Codable {
//    let url: String?
//    let label: String
//    let active: Bool
//
//    init(url: String?, label: String, active: Bool) {
//        self.url = url
//        self.label = label
//        self.active = active
//    }
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

