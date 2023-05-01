//
//  AnimeAppApp.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import SwiftUI

@main
struct AnimeAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: AnimesVM())
        }
    }
}
