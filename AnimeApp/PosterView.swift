//
//  PosterView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 3/9/23.
//

import SwiftUI

struct PosterView: View {
    let anime:Anime
    @EnvironmentObject var vm:AnimesVM
    
    var body: some View {
        AsyncImage(url: anime.image) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width:140, height: 180)
                .cornerRadius(16)
        } placeholder: {
            Image("dissapointed-flower")
                .resizable()
                .scaledToFit()
                .frame(width:140, height: 180)
                .padding(40)
                .background{
                    Color.primary.opacity(0.2)
                }
        }
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
        PosterView(anime: .test)
    }
}
