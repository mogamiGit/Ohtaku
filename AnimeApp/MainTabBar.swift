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
            Group {
                AnimeListView()
                    .tabItem {
                        Label("Anime", systemImage: "list.triangle")
                    }
                WacthListView()
                    .tabItem {
                        Label("Watch list", systemImage: "eye")
                    }
            }
            .toolbarBackground(Color.backgroundAcid
                               , for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(Color.mainAcid)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
            .environmentObject(AnimesVM.preview)
    }
}
