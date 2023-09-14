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
                            ForEach(AnimesVM.AnimeSortedBy.allCases, id: \.self) {
                                sorted in
                                Text(sorted.rawValue)
                            }
                        } label: {
                            Text("Ordenar por")
                        }
                    }
                }
                if vm.sorted == .type {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu("\(vm.byType.rawValue)") {
                            ForEach(AnimesVM.AnimeByType.allCases, id: \.self) { type in
                                Button {
                                    vm.byType = type
                                } label: {
                                    Text(type.rawValue)
                                }
                            }
                        }
                    }
                } else if vm.sorted != .none {
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
            .toolbarBackground(Color.backgroundAcid, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .animation(.default, value: vm.search)
            .navigationDestination(for: AnimeModel.self) { anime in
                DetailView(isWatched: anime.isWatched, anime: anime)
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
