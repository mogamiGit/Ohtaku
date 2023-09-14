//
//  MoreInfoDetailView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 20/5/23.
//

import SwiftUI

struct MoreInfoDetailView: View {
    let anime: AnimeModel
    @Binding var backAnimes:Bool
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {
            VStack() {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .fill(Color.backgroundAcid)
                        .frame(height: 60)
                        .ignoresSafeArea()
                    Button {
                        backAnimes.toggle()
                    } label: {
                        Image(systemName: "xmark.square.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:30)
                            .tint(Color.black)
                            .padding(.horizontal)
                    }
                }
            }
            ScrollView {
                Text(anime.description ?? "")
                    .font(.body)
                    .padding(30)
            }
        }
        .onDisappear{
            backAnimes = false
        }
        .ignoresSafeArea()
    }
}

struct MoreInfoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInfoDetailView(anime: .test, backAnimes: .constant(false))
    }
}
