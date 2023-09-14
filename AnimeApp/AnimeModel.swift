//
//  AnimeModel.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 28/8/23.
//

import Foundation

struct AnimeModel: Codable, Identifiable, Hashable {
    var id = UUID()
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
    var isWatched:Bool
    
    var genresArray: [String] {
        genres?.components(separatedBy: ",") ?? ["No genres"]
    }
    
    var rateInt: Int {
        Int(Double(rateStart) ?? 0.0)
    }
}

enum Status: String, Codable {
    case enEmision = "En emision"
    case finalizado = "Finalizado"
    case proximamente = "Proximamente"
    case unknown = "Unknown"
}

enum Types: String, Codable {
    case anime = "Anime"
    case especial = "Especial"
    case ova = "OVA"
    case pelicula = "Película"
    case unknown = "Unknown"
}

extension AnimeDTO {
    func mapToModel() -> AnimeModel {
        AnimeModel(title: title,
              description: description,
              year: year,
              type: Types(rawValue: type) ?? .unknown,
              genres: genres,
              rateStart: rateStart,
              votes: votes,
              status: Status(rawValue: status) ?? .unknown,
              followers: followers,
              episodes: episodes,
              urlAnime: urlAnime,
              image: image,
              isWatched: false)
    }
}
