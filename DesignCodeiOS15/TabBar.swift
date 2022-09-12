//
//  TabBar.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-07.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab: Tab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    ContentView()

                case .explore:
                    AccountView()

                case .notifications:
                    Text("Notification")

                case .library:
                    Text("Library")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack {
                ForEach(Tab.allCases, id: \.id) { tabItem in
                    Button(action: { selectedTab = tabItem }) {
                        VStack(spacing: 0) {
                            Image(systemName: tabItem.icon)
                                .symbolVariant(.fill)
                                .font(.body.bold())
                                .frame(width: 44, height: 29)
                            Text(tabItem.title)
                                .font(.caption2)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .foregroundStyle(selectedTab == tabItem ? .primary : .secondary)
                }
                .padding(.horizontal, 8)
            }
            .padding(.top, 14)
            .frame(height: 88, alignment: .top)
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 34, style: .continuous)
            )
            .strokeStyle(cornerRadius: 34)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
