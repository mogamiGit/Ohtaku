//
//  TagType.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 15/5/23.
//

import SwiftUI

struct TagType: View {
    let anime: Anime
    
    var body: some View {
        Text(anime.type.rawValue)
            .font(.subheadline)
            .foregroundColor(.black)
            .padding(5)
            .background{
                switch anime.type {
                case .anime :
                    Color.secondaryAcid
                case .especial:
                    Color.accentAcid
                case .ova:
                    Color.accentAcid
                case .pelicula:
                    Color.secondaryAcidTwo
                case .unknown:
                    Color.gray
                }
            }
    }
}

struct TagType_Previews: PreviewProvider {
    static var previews: some View {
        TagType(anime: .test)
    }
}
