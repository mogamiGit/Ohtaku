//
//  SplashScreenView.swift
//  AnimeApp
//
//  Created by Monica Galan de la Llana on 22/5/23.
//

import SwiftUI
import Lottie

struct SplashScreenView: View {
    
    var body: some View {
        ZStack {
            Color.mainAcid.ignoresSafeArea()
            ZStack {
                LottieView(nameLottieFile: "Acid-sun", loopMode: .loop, animationSpeed: 1)
                    .scaleEffect(0.25)
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
