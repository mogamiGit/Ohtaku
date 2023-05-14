//
//  ContentView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm:AnimesVM
    
    var body: some View {
        NavigationStack {
            List(vm.animesSearch) { anime in
                NavigationLink(value: anime) {
                    AnimeCell(anime: anime)
                }
            }
            .searchable(text: $vm.search)
            .animation(.default, value: vm.search)
            .navigationDestination(for: Anime.self) { anime in
                DetailView(anime: anime)
            }
            .listStyle(.grouped)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AnimesVM.preview)
    }
}
