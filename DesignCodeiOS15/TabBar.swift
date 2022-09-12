//
//  TabBar.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-07.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab: Tab = .home
    
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
                }
                .padding(.horizontal, 8)
            }
            .padding(.top, 14)
            .frame(height: 88, alignment: .top)
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 34, style: .continuous)
            )
            .background(
                HStack {
                    spacersBeforeSelection
                    Circle()
                        .fill(selectedTab.color)
                        .frame(width: 80)
                    spacersAfterSelection
                }
                    .padding(.horizontal, 8)
            )
            .overlay {
                HStack(alignment: .center) {
                    spacersBeforeSelection
                    Rectangle()
                        .fill(selectedTab.color)
                        .frame(width: 28, height: 5)
                        .cornerRadius(3)
                        .frame(width: 80)
                        .frame(maxHeight: .infinity, alignment: .top)
                    spacersAfterSelection
                }
                    .padding(.horizontal, 8)
            }
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
