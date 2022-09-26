//
//  AnimatableFontModifier.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-26.
//

import SwiftUI

struct AnimatableFontModifier: Animatable, ViewModifier {
    var size: Double
    var weight: Font.Weight
    var design: Font.Design

    var animatableData: Double {
        get { size }
        set {
            size = newValue
            if size <= 26 {
                weight = .semibold
            } else {
                weight = .bold
            }
        }
    }

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}

extension View {
    func animatableFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        modifier(AnimatableFontModifier(size: size, weight: weight, design: design))
    }
}
