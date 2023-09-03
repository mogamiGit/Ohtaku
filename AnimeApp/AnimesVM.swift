//
//  AnimesVM.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation
import SwiftUI

final class AnimesVM:ObservableObject {
    enum animeSortedBy: String, CaseIterable, Identifiable {
        var id: animeSortedBy { self }
        
        case title = "Por título"
        case year = "Por año"
        case type = "Por tipo"
        case none = "Ninguno"
    }
    
    enum animeByType: String, CaseIterable, Identifiable {
        var id: animeByType { self }
        
        case anime = "Anime"
        case especial = "Especial"
        case ova = "OVA"
        case pelicula = "Película"
        case none = "Ninguno"
    }
    
    enum sortChangeOrder {
        case ascending
        case descending
    }
    
    let persistence:Persistence
    var error:String = ""
    
    @Published var animes:[Anime]
    @Published var search = ""
    @Published var sorted:animeSortedBy = .none
    @Published var byType:animeByType = .none
    @Published var changeSort:sortChangeOrder = .ascending
    
    var animesSearch:[Anime] {
        animes.filter { anime in
            if search.isEmpty {
                return true
            } else {
                return anime.title.lowercased().contains(search.lowercased())
            }
        }.filter { anime in
            if sorted != .type {
                return true
            } else {
                switch byType {
                case .anime:
                    return anime.type == .anime
                case .especial:
                    return anime.type == .especial
                case .ova:
                    return anime.type == .ova
                case .pelicula:
                    return anime.type == .pelicula
                case .none:
                    return true
                }
            }
        }.sorted { a1, a2 in
            switch sorted {
            case .title:
                if changeSort == .ascending {
                    return a1.title >= a2.title
                } else {
                    return a1.title <= a2.title
                }
            case .year:
                if changeSort == .ascending {
                    return a1.year > a2.year
                } else {
                    return a1.year < a2.year
                }
            case .type:
                return true
            case .none:
                return true
            }
        }
    }
    
    init(persistence:Persistence = .shared) {
        self.persistence = persistence
        do {
            self.animes = try persistence.loadAnimes()
        } catch {
            print("Error VM \(error)")
            self.animes = []
        }
    }
    
    func toggleSortOrder() {
        if changeSort == .ascending {
            changeSort = .descending
        } else {
            changeSort = .ascending
        }
    }
    
    func starRate(num:Int, image:String) -> some View {
        ForEach(1...num, id: \.self) { _ in
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .foregroundColor(Color.mainAcid)
        }
    }
    
    func relatedAnimes(genre:String, currentAnime:Anime) -> [Anime] {
        let related = animes.filter { $0.genres == genre && $0.id != currentAnime.id }.prefix(8)
        return Array(related)
    }
    
    func toggleWatched(anime: Anime) {
        if let index = animes.firstIndex(where: { $0.id == anime.id }) {
            animes[index].isWatched.toggle()
            
            do {
                try persistence.saveWatchedJSON(animes: animes)
            } catch {
                print("Error toggleWatched \(error)")
                self.error = error.localizedDescription
            }
        }
    }
    
    func recoverWatchedAnimes() -> [Anime] {
        return animes.filter { $0.isWatched == true }
    }
}
