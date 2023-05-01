//
//  ContentView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 23/4/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm:AnimesVM
    
    var body: some View {
        List(vm.animes) { anime in
            HStack {
                Text(anime.title)
                    .font(.headline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: .preview)
    }
}
