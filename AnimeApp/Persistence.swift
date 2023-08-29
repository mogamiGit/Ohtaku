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
        print(watchedAnimesURL)
        if FileManager.default.fileExists(atPath: watchedAnimesURL.path()) {
            let data = try Data(contentsOf: watchedAnimesURL)
            return try JSONDecoder().decode([Anime].self, from: data)
        } else {
            let data = try Data(contentsOf: fileLocation.fileURL)
            let realData = try JSONDecoder().decode([AnimeModel].self, from: data)
            let localData = realData.map { $0.mapToModel() }
            let localDataToEncode = try JSONEncoder().encode(localData)
            try localDataToEncode.write(to: watchedAnimesURL, options: .atomic)
            return try JSONDecoder().decode([Anime].self, from: localDataToEncode)
        }
    }
    
    func saveWatchedJSON(animes: [Anime]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let savedData = try encoder.encode(animes)
        try savedData.write(to: watchedAnimesURL)
    }

}
