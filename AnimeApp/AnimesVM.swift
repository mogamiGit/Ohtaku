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
    @Published var changeSort:sortChangeOrder = .ascending
    
    // Crear en la view del Detail un apartado que solo aparezca cuando tiene OVAS o pelis. Con una función que capture la primera palabra del título (o parte) y cree un filtrp para que pinte solo los que estén relacionados.
    // Crear un apartado de animes relacionados con un filtro de géneros.
    
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
    
    func toggleSortOrder() {
        if changeSort == .ascending {
            changeSort = .descending
        } else {
            changeSort = .ascending
        }
    }
    
    func starRate(num:Int, image:String) -> some View {
        ForEach(1...num, id: \.self) { n in
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 20)
                .foregroundColor(Color.mainAcid)
        }
    }
}
