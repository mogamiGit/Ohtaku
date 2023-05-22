//
//  MoreInfoDetailView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 20/5/23.
//

import SwiftUI

struct MoreInfoDetailView: View {
    let anime: Anime
    @Binding var backAnimes:Bool
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 20) {
            Button {
                backAnimes.toggle()
            } label: {
                Image(systemName: "x.square.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width:30)
            }
            Text(anime.description ?? "")
            Spacer()
        }
        .padding()
        .onDisappear{
            backAnimes = false
        }
    }
}

struct MoreInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInfoDetailView(anime: .test, backAnimes: .constant(false))
    }
}
