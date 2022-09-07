//
//  TabBar.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-07.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ContentView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack {
                ForEach(tabItems, id: \.id) { tabItem in
                    VStack(spacing: 0) {
                        Image(systemName: tabItem.icon)
                            .symbolVariant(.fill)
                            .font(.body.bold())
                            .frame(width: 44, height: 29)
                        Text(tabItem.text)
                            .font(.caption2)
                    }
                    .frame(maxWidth: .infinity)
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
