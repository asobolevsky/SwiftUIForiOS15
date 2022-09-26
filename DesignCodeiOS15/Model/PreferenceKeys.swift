//
//  PreferenceKeys.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-23.
//

import SwiftUI

extension PreferenceKey where Value == CGFloat {
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TabPreferencyKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
}

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
}
