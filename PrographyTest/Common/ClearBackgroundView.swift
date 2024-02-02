//
//  ClearBackgroundView.swift
//  PrographyTest
//
//  Created by LJh on 2/2/24.
//

import SwiftUI
import UIKit

final class ClearBackgroundView: UIView {
    public override func layoutSubviews() {
        guard let parentView = superview?.superview else {
            return
        }
        parentView.backgroundColor = .clear
    }
}

struct ClearBackground: UIViewRepresentable {
    public func makeUIView(context: Context) -> UIView {
        
        let view = ClearBackgroundView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {}
}
