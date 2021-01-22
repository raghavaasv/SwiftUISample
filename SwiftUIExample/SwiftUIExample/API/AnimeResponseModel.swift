//
//  AnimeResponseModel.swift
//  SwiftUIExample
//
//  Created by Sri on 1/21/21.
//

import Foundation
///  Struct: AnimeResponseModel
///
///  Response Model to capture the Anime search results
///
struct AnimeResponseModel: Codable {
    let results: [Result]
    
    struct Result: Codable {
        let malId: Int
        let url: String
        let imageUrl: String
        let title: String
        let airing: Bool
        let synopsis: String
        let type: String
        let episodes: Int
        let score: Double
        let startDate: String?
        let endDate: String?
        let members: Int
        let rated: String?
        
        enum CodingKeys: String, CodingKey {
            case malId = "mal_id"
            case url
            case imageUrl = "image_url"
            case title
            case airing
            case synopsis
            case type
            case episodes
            case score
            case startDate = "start_date"
            case endDate = "end_date"
            case members
            case rated
        }
    }
}
