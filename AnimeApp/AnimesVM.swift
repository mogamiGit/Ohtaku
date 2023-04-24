//
//  AnimesVM.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation

final class AnimesVM:ObservableObject {
    static let shared = AnimesVM()
    let persistence = Persistence.shared
    
    @Published var animes:[Anime]
    
    init() {
        do {
            self.animes = try persistence.loadAnimes()
        } catch {
            print(error)
            self.animes = []
        }
    }
}
