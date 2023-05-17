//
//  Detail.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 2/5/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var vm:AnimesVM
    
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
            ScrollView {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(.white)
                    LazyVStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            TagType(anime: anime)
                            Text(anime.title)
                                .font(.largeTitle)
                            HStack(spacing: 5){
                                ForEach(anime.genresArray.prefix(4), id: \.self){ genre in
                                    Text(genre)
                                        .font(.caption)
                                        .foregroundColor(Color.mainAcid)
                                        .padding(5)
                                        .background{
                                            RoundedRectangle(cornerRadius: 2)
                                                .stroke(Color.mainAcid)
                                        }
                                }
                            }
                        }
                        ZStack(alignment: .bottom) {
                            AsyncImage(url: anime.image) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    
                            } placeholder: {
                                Image("dissapointed-flower")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(70)
                                    .background{ Color.primary.opacity(0.2) }
                            }
                            ZStack {
                                Rectangle()
                                    .frame(height: 50)
                                    .background{
                                        switch anime.status {
                                        case .enEmision:
                                            Color.orange
                                                .opacity(0.6)
                                        case .finalizado:
                                            Color.green.opacity(0.6)
                                        case .proximamente:
                                            Color.black.opacity(0.6)
                                        }
                                    }
                                Text(anime.status.rawValue)
                                    .foregroundColor(.white)
                                    
                            }
                            
                        }
                        Text("\(anime.episodes) Episodios")
                            .font(.title3)
                        HStack(spacing: 20) {
                            VStack(alignment: .leading) {
                                Text("Calificación")
                                    .fontWeight(.bold)
                                LazyHStack {
                                    ZStack(alignment: .leading) {
                                        HStack {
                                            vm.starRate(num:5, image: "star")
                                        }
                                        HStack {
                                            vm.starRate(num:anime.rateInt, image: "star.fill")
                                        }
                                    }
                                    Text(anime.rateStart)
                                }
                            }
                            Divider()
                            VStack(alignment: .leading) {
                                Text("Votos")
                                    .fontWeight(.bold)
                                Text("\(anime.votes)")
                            }
                            .padding(8)
                            .background{
                                Color.accentAcid.opacity(0.6)
                            }
                        }
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Sinopsis")
                                .fontWeight(.bold)
                            Text(anime.description ?? "")
                                .font(.subheadline)
                                .lineLimit(4)
                            Button {
                                //
                            } label: {
                                Text("ver más")
                            }
                        }
                        Button {
                            //
                        } label: {
                            Text("Ver más")
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom)
                    }
                    .padding()
                }
                .cornerRadius(10)
                .padding(.horizontal,10)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(anime: .test)
            .environmentObject(AnimesVM.preview)
    }
}
