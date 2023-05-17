//
//  AnimeModel.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation

// MARK: - AnimeModel
struct Anime: Codable, Identifiable, Hashable {
    let id = UUID()
    let title:String
    let description:String?
    let year:Int
    let type:Types
    let genres:String?
    let rateStart:String
    let votes:Int
    let status:Status
    let followers:Int
    let episodes:Int
    let urlAnime:URL
    let image:URL
    
    var genresArray: [String] {
        genres?.components(separatedBy: ",") ?? ["No genres"]
    }
    
    var rateInt: Int {
        Int(Double(rateStart) ?? 0.0)
    }
    
    enum CodingKeys: String, CodingKey {
        case title, description, year, type, votes, status, followers, episodes,image, genres
        case rateStart = "rate_start"
        case urlAnime = "url_anime"
    }
}

enum Status: String, Codable {
    case enEmision = "En emision"
    case finalizado = "Finalizado"
    case proximamente = "Proximamente"
}

enum Types: String, Codable {
    case anime = "Anime"
    case especial = "Especial"
    case ova = "OVA"
    case pelicula = "Película"
}
