//
//  DataTest.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 1/5/23.
//

import Foundation

struct FilePreview: FileLocation {
    var fileURL: URL {
        Bundle.main.url(forResource: "animeTest", withExtension: "json")!
    }
}

extension AnimesVM {
    static let preview = AnimesVM(persistence: Persistence(fileLocation: FilePreview()))
}
