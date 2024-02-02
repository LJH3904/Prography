//
//  View+Extension.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI

extension View {
    func setSkeletonView(opacity: Double, shouldShow: Bool) -> some View {
        self.modifier(BlinkingAnimationModifier(shouldShow: shouldShow, opacity: opacity))
    }
}
