//
//  AnimesVM.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import Foundation

final class AnimesVM:ObservableObject {
    enum animeSortedBy: String, CaseIterable, Identifiable {
        var id: animeSortedBy { self }
        
        case title = "Por título"
        case year = "Por año"
        case none = "Ninguno"
    }
    
    enum sortChangeOrder {
        case ascending
        case descending
    }
    
    //meter otro toolbaritem para cambiar el orden ascendente y descendente. Cuando está descendente cambia la flecha para pulsar hacia arriba y vicaversa.
    
    static let shared = AnimesVM()
    
    let persistence:Persistence
    
    @Published var animes:[Anime]
    @Published var search = ""
    @Published var sorted:animeSortedBy = .none
    @Published var changeSort:sortChangeOrder = .ascending
    
    var animesSearch:[Anime] {
        let animesFiltered = animes.filter { anime in
            if search.isEmpty {
                return true
            } else {
                return anime.title.lowercased().contains(search.lowercased())
            }
        }
        
        let sortedAnimes = animesFiltered.sorted { a1, a2 in
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
            case .none:
                return true
            }
        }
        
        return sortedAnimes
        
        /*
        if changeSort == .ascending {
            return sortedAnimes
        } else {
            return sortedAnimes.reversed()
        }
        */
    }
    
    func toggleSortOrder() {
        if changeSort == .ascending {
            changeSort = .descending
        } else {
            changeSort = .ascending
        }
    }
    
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
