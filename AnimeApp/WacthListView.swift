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
                Text("No hay animes vistos")
            }
            ScrollView {
                LazyVGrid(columns: [GridItem(),GridItem()]) {
                    ForEach(vm.recoverWatchedAnimes()) { anime in
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
                .padding(.horizontal)
            }
        }
    }
}

struct WacthListView_Previews: PreviewProvider {
    static var previews: some View {
        WacthListView()
    }
}
