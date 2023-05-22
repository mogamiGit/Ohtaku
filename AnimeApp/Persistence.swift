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
    
    init(fileLocation:FileLocation = FileProduction()) {
        self.fileLocation = fileLocation
    }
    
    func loadAnimes() throws -> [Anime] {
        let data = try Data(contentsOf: fileLocation.fileURL)
        return try JSONDecoder().decode([Anime].self, from: data)
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
