//
//  TabBar.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-07.
//

import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Tab
    @State private var tabItemWidth: CGFloat = 0
    
    var body: some View {
        HStack {
            buttons
        }
        .padding(.top, 14)
        .frame(height: 88, alignment: .top)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 34, style: .continuous)
        )
        .background(selectedTabItemBackground)
        .overlay(selectedTabItemIndicator)
        .strokeStyle(cornerRadius: 34)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea(.all, edges: .bottom)
    }

    @ViewBuilder
    private var spacersBeforeSelection: some View {
        switch selectedTab {
        case .home:
            EmptyView()
        case .explore:
            Spacer()
        case .notifications:
            Spacer()
            Spacer()
        case .library:
            Spacer()
        }
    }

    @ViewBuilder
    private var spacersAfterSelection: some View {
        switch selectedTab {
        case .home:
            Spacer()
        case .explore:
            Spacer()
            Spacer()
        case .notifications:
            Spacer()
        case .library:
            EmptyView()
        }
    }

    private var selectedTabItemBackground: some View {
        HStack {
            spacersBeforeSelection
            Circle()
                .fill(selectedTab.color)
                .frame(width: tabItemWidth)
            spacersAfterSelection
        }
            .padding(.horizontal, 8)
    }

    private var selectedTabItemIndicator: some View {
        HStack {
            spacersBeforeSelection
            Rectangle()
                .fill(selectedTab.color)
                .frame(width: 28, height: 5)
                .cornerRadius(3)
                .frame(width: tabItemWidth)
                .frame(maxHeight: .infinity, alignment: .top)
            spacersAfterSelection
        }
            .padding(.horizontal, 8)
    }

    private var buttons: some View {
        ForEach(Tab.allCases, id: \.id) { tabItem in
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedTab = tabItem
                }
            } label: {
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
            .blendMode(selectedTab == tabItem ? .overlay : .normal)
            .overlay(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: TabPreferencyKey.self, value: proxy.size.width)
                }
            )
            .onPreferenceChange(TabPreferencyKey.self) { value in
                tabItemWidth = value
            }
        }
        .padding(.horizontal, 8)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.home))
    }
}
