//
//  LottieView.swift
//  Ohtaku
//
//  Created by Monica Galan de la Llana on 5/9/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let nameLottieFile: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        
        let animationView = LottieAnimationView(name: nameLottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        
        return animationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}
