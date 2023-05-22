//
//  Detail.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 2/5/23.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var vm:AnimesVM
    @State var showMore = false
    
    let anime: Anime
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            switch anime.type {
            case .anime:
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
                            HStack {
                                TagType(anime: anime)
                                Spacer()
                                Button {
                                    vm.watchedAnime(currentanime: anime)
                                } label: {
                                    Image(systemName: vm.isAnimeWatched(currentanime: anime) ? "heart.fill" : "heart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                }

                            }
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
                                    .fill(getStatusColor())
                                    .frame(height: 50)
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
                                showMore.toggle()
                            } label: {
                                Text("ver más")
                            }
                            .sheet(isPresented: $showMore, onDismiss: {
                                showMore.toggle()
                            }) {
                                MoreInfoDetailView(anime: anime, backAnimes: $showMore)
                            }
                        }
                        VStack(alignment: .leading){
                            Text("Animes relacionados")
                                .fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: [GridItem()]) {
                                    ForEach(vm.relatedAnimes(genre: anime.genresArray.first ?? "", currentAnime: anime)) { anime in
                                        NavigationLink(value:anime) {
                                            AsyncImage(url: anime.image) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width:100, height: 140)
                                            } placeholder: {
                                                Image("dissapointed-flower")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .padding().frame(width:100, height: 140)
                                                    .background{
                                                        Color.primary.opacity(0.2)
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Button {
                            //
                        } label: {
                            Link(destination:anime.urlAnime) {
                                Text("Más info")
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .padding(.bottom)
                    }
                    .padding()
                }
                .cornerRadius(5)
                .padding(.horizontal,10)
            }
            .toolbar {
                ShareLink("Compartir", item: anime.urlAnime)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
    
    func getStatusColor() -> Color {
        switch anime.status {
        case .enEmision:
            return Color.orange.opacity(0.9)
        case .finalizado:
            return Color.green.opacity(0.9)
        case .proximamente:
            return Color.black.opacity(0.9)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(anime: .test)
                .environmentObject(AnimesVM.preview)
        }
    }
}
