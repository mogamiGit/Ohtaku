//
//  Detail.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 2/5/23.
//

import SwiftUI

struct DetailView: View {
    let anime: Anime
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            switch anime.type {
            case .anime :
                Color.secondaryAcid
                    .ignoresSafeArea()
            case .especial:
                Color.accentAcid
                    .ignoresSafeArea()
            case .ova:
                Color.accentAcid
                    .ignoresSafeArea()
            case .pelicula:
                Color.secondaryAcidTwo
                    .ignoresSafeArea()
            }
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(.white)
                LazyVStack(alignment: .leading) {
                    ZStack {
                        AsyncImage(url: anime.image) { cover in
                            cover
                                .resizable()
                                .scaledToFit()
                                .frame(width: .infinity)
                        } placeholder: {
                            //
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(anime.title)
                            .font(.title)
                        Text(anime.type.rawValue)
                            .font(.callout)
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
                                }
                            }
                    }
                    .padding()
                }
            }
            .cornerRadius(10)
            .padding(.horizontal,10)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(anime: .test)
    }
}
