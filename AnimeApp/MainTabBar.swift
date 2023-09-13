//
//  MainTabBar.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 20/5/23.
//

import SwiftUI

struct MainTabBar: View {
    @State var isActive = false
    
    var body: some View {
        if isActive {
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
        } else {
            SplashScreenView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
            .environmentObject(AnimesVM.preview)
    }
}
