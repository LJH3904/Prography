//
//  BlinkingAnimationModifier.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

struct BlinkingAnimationModifier: AnimatableModifier {
    var shouldShow : Bool
    var opacity: Double
    
    var animatableData: Double {
        get { opacity }
        set { opacity = newValue }
    }
    
    func body(content: Content) -> some View {
        content.overlay(
            ZStack{
                Color.white.zIndex(0)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.5))
                    .opacity(self.opacity).zIndex(1)
            }.opacity(self.shouldShow ? 1 : 0)
        )
    }
}
