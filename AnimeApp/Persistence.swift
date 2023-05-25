//
//  Persistence.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation

protocol FileLocation {
    var fileURL:URL { get }
}

struct FileProduction:FileLocation {
    var fileURL: URL {
        Bundle.main.url(forResource: "anime", withExtension: "json")!
    }
}

final class Persistence {
    static let shared = Persistence()
    
    let fileLocation:FileLocation
    let watchedAnimesURL = URL.documentsDirectory.appending(path: "watchedAnimes.json")
    let animesURL = URL.documentsDirectory.appending(path: "animes.json")
    
    init(fileLocation:FileLocation = FileProduction()) {
        self.fileLocation = fileLocation
    }
    
    func loadAnimes() throws -> [Anime] {
        do {
            let data = try Data(contentsOf: animesURL)
            print(animesURL)
            return try JSONDecoder().decode([Anime].self, from: data)
        } catch {
            let data = try Data(contentsOf: fileLocation.fileURL)
            let animes = try JSONDecoder().decode([Anime].self, from: data)
            try? saveAnimes(animes: animes)
            return animes
        }
    }
    
    private func saveAnimes(animes: [Anime]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let savedData = try encoder.encode(animes)
        try savedData.write(to: animesURL)
    }
    
    func saveWatchedAnimes(array:[Anime]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let savedData = try encoder.encode(array)
        try savedData.write(to: watchedAnimesURL)
        print(watchedAnimesURL)
    }
    
    func loadWatchedAnimes() throws -> [Anime] {
        let data = try Data(contentsOf: watchedAnimesURL)
        return try JSONDecoder().decode([Anime].self, from: data)
    }
}
