//
//  NewsFeed.swift
//  TestCasai
//
//  Created by Ezequiel Barreto on 17/11/20.
//

import Foundation

// MARK: - NewsFeed
struct NewsFeed: Codable {
    let status: String
    let totalResults: Int
   let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id: Int
    let acf: AcfUnion
}

enum AcfUnion: Codable {
    case acfClass(AcfClass)
    case bool(Bool)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(AcfClass.self) {
            self = .acfClass(x)
            return
        }
        throw DecodingError.typeMismatch(AcfUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AcfUnion"))
    }
    
    func getAcg() -> Any {
        switch self {
        case .acfClass(let afc):
            return afc
        case .bool(let bool):
            return bool
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .acfClass(let x):
            try container.encode(x)
        case .bool(let x):
            try container.encode(x)
        }
    }
}

// MARK: - AcfClass
struct AcfClass: Codable {
    let source: Source
    let author: String
    let title, description: String
    let url: String
    let placePhoto: PlacePhoto
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title, description
        case url
        case placePhoto = "place_photo"
        case publishedAt, content
    }
}


// MARK: - PlacePhoto
struct PlacePhoto: Codable {
    let size: String
    let images: [String]
}

struct Source: Codable {
    let id: String?
    let name: String
}
