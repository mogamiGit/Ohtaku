//
//  MainTabBar.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 20/5/23.
//

import SwiftUI

struct MainTabBar: View {
    var body: some View {
        TabView {
            AnimeListView()
                .tabItem {
                    Label("Anime", systemImage: "star")
                }
            WacthListView()
                .tabItem {
                    Label("Watch list", systemImage: "eye")
                }
        }
        .tint(.blue)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
            .environmentObject(AnimesVM.preview)
    }
}
