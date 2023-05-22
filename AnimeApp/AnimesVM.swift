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
    
    @Published var animes:[Anime]
    @Published var search = ""
    @Published var sorted:animeSortedBy = .none
    @Published var byType:animeByType = .none
    @Published var changeSort:sortChangeOrder = .ascending
    @Published var arrayWatchedAnimes:[Anime] = []
    
    // Crear en la view del Detail un apartado que solo aparezca cuando tiene OVAS o pelis. Con una función que capture la primera palabra del título (o parte) y cree un filtrp para que pinte solo los que estén relacionados.
    
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
        do {
            self.persistence = persistence
            self.animes = try persistence.loadAnimes()
            if FileManager.default.fileExists(atPath: persistence.watchedAnimesURL.path()) {
                self.arrayWatchedAnimes = try persistence.loadWatchedAnimes()
            }
        } catch {
            debugPrint(error)
            self.animes = []
            self.arrayWatchedAnimes = []
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
    
    func isAnimeWatched(currentanime:Anime) -> Bool {
        arrayWatchedAnimes.contains(where: { $0.id == currentanime.id })
    }
    
    func watchedAnime(currentanime:Anime) {
        for anime in animes where anime.id == currentanime.id {
            if isAnimeWatched(currentanime: anime) {
                arrayWatchedAnimes.removeAll(where: { $0.id == anime.id })
                
                do {
                    print(arrayWatchedAnimes)
                    try persistence.saveWatchedAnimes(array: arrayWatchedAnimes)
                } catch {
                    print("error al guardar")
                }
                print(arrayWatchedAnimes)
            } else {
                arrayWatchedAnimes.append(anime)
                
                do {
                    try persistence.saveWatchedAnimes(array: arrayWatchedAnimes)
                } catch {
                    print("error al guardar")
                }
                print(arrayWatchedAnimes)
            }
        }
    }
}
