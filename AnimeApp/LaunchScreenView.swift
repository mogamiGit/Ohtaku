//
//  LaunchScreenView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 22/5/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @State var animatingPhase = false
    
    var body: some View {
        ZStack {
            Color.secondaryAcid.ignoresSafeArea()
            ZStack {
                Image("acid-sun")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
