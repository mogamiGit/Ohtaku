//
//  AnimeCell.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 1/5/23.
//

import SwiftUI

struct AnimeCell: View {
    let anime: Anime
    
    var body: some View {
        HStack(alignment: .center) {
            ZStack(alignment: .topLeading) {
                AsyncImage(url: anime.image) { image in
                    image
                        .resizable()
                        .frame(width: 150, height: 220)
                } placeholder: {
                    Image("dissapointed-flower")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: 150, height: 220)
                        .background{ Color.primary.opacity(0.2) }
                }
                .cornerRadius(5)
                TagType(anime: anime)
                    .padding(8)
            }
            .padding(10)
            VStack(alignment: .leading) {
                Text(anime.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                if anime.episodes > 1{
                    Text("\(anime.episodes) Episodios")
                        .font(.callout)
                        .fontWeight(.light)
                        .padding(.bottom, 10)
                }
                HStack(spacing: 5){
                    ForEach(anime.genresArray.prefix(2), id: \.self){ genre in
                        Text(genre)
                            .font(.caption2)
                            .foregroundColor(Color.mainAcid)
                            .padding(5)
                            .background{
                                RoundedRectangle(cornerRadius: 2)
                                    .stroke(Color.mainAcid)
                            }
                    }
                }
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct AnimeCell_Previews: PreviewProvider {
    static var previews: some View {
        AnimeCell(anime: .test)
    }
}
