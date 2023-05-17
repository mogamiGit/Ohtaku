//
//  AnimeListView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import SwiftUI

struct AnimeListView: View {
    @EnvironmentObject var vm:AnimesVM
    @State var changeOrder = false
    
    var body: some View {
        NavigationStack {
            List(vm.animesSearch) { anime in
                NavigationLink(value: anime) {
                    AnimeCell(anime: anime)
                }
            }
            .searchable(text: $vm.search)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu("Ordenar por") {
                        Picker(selection: $vm.sorted) {
                            ForEach(AnimesVM.animeSortedBy.allCases) {
                                sorted in
                                Text(sorted.rawValue)
                            }
                        } label: {
                            Text("Ordenar por")
                        }
                    }
                }
                if vm.sorted != .none {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            changeOrder.toggle()
                            vm.toggleSortOrder()
                        } label: {
                            if changeOrder {
                                Image(systemName: "arrow.down")
                            } else {
                                Image(systemName: "arrow.up")
                            }
                        }
                    }
                }
            }
            .animation(.default, value: vm.search)
            .navigationDestination(for: Anime.self) { anime in
                DetailView(anime: anime)
            }
            .listStyle(.grouped)
        }
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListView()
            .environmentObject(AnimesVM.preview)
    }
}
