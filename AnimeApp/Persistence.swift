//
//  Persistence.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation

final class Persistence {
    static let shared = Persistence()
    
    let url = Bundle.main.url(forResource: "anime", withExtension: "json")!
    
    func loadAnimes() throws -> [Anime] {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Anime].self, from: data)
    }
}
