//
//  ContentView.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-08-29.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") private var selectedTab: Tab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            switch selectedTab {
            case .home:
                HomeView()

            case .explore:
                AccountView()

            case .notifications:
                Text("Notification")

            case .library:
                Text("Library")
            }

            TabBar(selectedTab: $selectedTab)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 13 mini")
    }
}
