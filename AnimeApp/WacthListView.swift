//
//  WacthListView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 20/5/23.
//

import SwiftUI

struct WacthListView: View {
    @EnvironmentObject var vm:AnimesVM
    
    var body: some View {
        NavigationStack {
            if vm.recoverWatchedAnimes().isEmpty {
                ZStack {
                    Color.mainAcid.ignoresSafeArea()
                    ZStack {
                        VStack {
                            Image("empty-head")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal, 50)
                                .padding(.vertical)
                            Text("Todavía no hay animes vistos")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                }
            } else {
                NavigationStack {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(),GridItem()]) {
                            ForEach(vm.recoverWatchedAnimes()) { anime in
                                NavigationLink(value: anime) {
                                    VStack(spacing: 20) {
                                        PosterView(anime: anime)
                                        Text(anime.title)
                                            .font(.title3)
                                            .frame(maxWidth: 150)
                                            .lineLimit(1)
                                    }
                                    .padding(.bottom)
                                }
                            }
                        }
                        .padding()
                    }
                }
                .navigationTitle("Mi lista")
                .navigationDestination(for: Anime.self) { anime in
                    DetailView(isWatched: anime.isWatched, anime: anime)
                }
            }
        }
    }
}

struct WacthListView_Previews: PreviewProvider {
    static var previews: some View {
        WacthListView()
            .environmentObject(AnimesVM.preview)
    }
}
