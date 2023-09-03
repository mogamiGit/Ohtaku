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
    @State var isWatched:Bool
    
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
            case .unknown:
                Color.gray
                    .ignoresSafeArea()
            }
            ScrollView {
                ZStack() {
                    Rectangle()
                        .fill(.background)
                    LazyVStack(alignment: .center, spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                TagType(anime: anime)
                                Spacer()
                                Button {
                                    vm.toggleWatched(anime: anime)
                                    isWatched.toggle()
                                } label: {
                                    Image(systemName: isWatched ? "eye.fill" : "eye")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                        .tint(Color.mainAcid)
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
                        PosterDetailView(anime: anime)
                        VStack(alignment: .leading, spacing: 25) {
                            Text("\(anime.episodes) Episodios")
                                .font(.title2)
                            HStack(spacing: 20) {
                                VStack(alignment: .leading) {
                                    Text("Calificación")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    LazyHStack {
                                        ZStack(alignment: .leading) {
                                            HStack {
                                                vm.starRate(num:5, image: "seal")
                                            }
                                            HStack {
                                                vm.starRate(num:anime.rateInt, image: "seal.fill")
                                            }
                                        }
                                        Text(anime.rateStart)
                                    }
                                }
                                Spacer()
                                Divider()
                                Spacer()
                                VStack() {
                                    Text("\(anime.votes)")
                                        .fontWeight(.bold)
                                    Text("Votos")
                                }
                                .padding()
                                .foregroundColor(.black)
                                .background{
                                    Color.accentAcid.opacity(0.6)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Sinopsis")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text(anime.description ?? "")
                                    .font(.body)
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
                                        .presentationDetents([.fraction(0.8)])
                                }
                            }
                            Button {
                                //
                            } label: {
                                Link(destination:anime.urlAnime) {
                                    Text("Más información")
                                        .foregroundColor(.white)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .controlSize(.large)
                            .tint(Color.mainAcid)
                            .padding(.vertical)
                        }
                    }
                    .padding()
                }
                .cornerRadius(8)
                .padding(.horizontal,10)
                VStack(alignment: .leading){
                    Text("Animes relacionados")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem()]) {
                            ForEach(vm.relatedAnimes(genre: anime.genresArray.first ?? "", currentAnime: anime)) { anime in
                                NavigationLink(value:anime) {
                                    PosterView(anime: anime)
                                        .padding(.leading)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 30)
                
            }
            .toolbar {
                ShareLink("Compartir", item: anime.urlAnime)
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(isWatched: true, anime: .test)
                .environmentObject(AnimesVM.preview)
        }
    }
}

struct PosterDetailView: View {
    let anime: Anime
    
    var body: some View {
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
        .frame(maxWidth: 500)
        .cornerRadius(5)
    }
    
    func getStatusColor() -> Color {
        switch anime.status {
        case .enEmision:
            return Color.secondaryAcidTwo.opacity(0.9)
        case .finalizado:
            return Color.black.opacity(0.9)
        case .proximamente:
            return Color.accentAcid.opacity(0.9)
        case .unknown:
            return Color.gray.opacity(0.9)
        }
    }
}
