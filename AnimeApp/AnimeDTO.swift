//
//  AnimeDTO.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation

// MARK: - AnimeDTO
struct AnimeDTO: Codable, Hashable {
    let title:String
    let description:String?
    let year:Int
    let type:String
    let genres:String?
    let rateStart:String
    let votes:Int
    let status:String
    let followers:Int
    let episodes:Int
    let urlAnime:URL
    let image:URL
    
    enum CodingKeys: String, CodingKey {
        case title, description, year, type, votes, status, followers, episodes,image, genres
        case rateStart = "rate_start"
        case urlAnime = "url_anime"
    }
}
