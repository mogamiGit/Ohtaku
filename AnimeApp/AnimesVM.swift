//
//  AnimesVM.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation

final class AnimesVM:ObservableObject {
    static let shared = AnimesVM()
    
    let persistence:Persistence
    
    @Published var animes:[Anime]
    
    init(persistence:Persistence = .shared) {
        do {
            self.persistence = persistence
            self.animes = try persistence.loadAnimes()
        } catch {
            debugPrint(error)
            self.animes = []
        }
    }
}
