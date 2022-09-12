//
//  Tab.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-07.
//

import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }

    case home
    case explore
    case notifications
    case library

    var title: String {
        switch self {
        case .home: return "Learn now"
        case .explore: return "Explore"
        case .notifications: return "Notifications"
        case .library: return "Library"
        }
    }

    var icon: String {
        switch self {
        case .home: return "house"
        case .explore: return "magnifyingglass"
        case .notifications: return "bell"
        case .library: return "rectangle.stack"
        }
    }

    var color: Color {
        switch self {
        case .home: return .teal
        case .explore: return .teal
        case .notifications: return .teal
        case .library: return .teal
        }
    }
}

struct TabPreferencyKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
