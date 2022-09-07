//
//  Tab.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-07.
//

import SwiftUI

struct TabItem: Identifiable {
    let id = UUID()
    let text: String
    let icon: String
}

var tabItems = [
    TabItem(text: "Learn now", icon: "house"),
    TabItem(text: "Explore", icon: "magnifyingglass"),
    TabItem(text: "Notifications", icon: "bell"),
    TabItem(text: "Library", icon: "rectangle.stack"),
]
