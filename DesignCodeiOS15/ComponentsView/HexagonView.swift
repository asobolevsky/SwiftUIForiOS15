//
//  HexogonView.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-04.
//

import SwiftUI

struct HexagonView: View {
    var body: some View {
        Canvas { context, size in
            context.draw(
                Text("DesignCode").font(.largeTitle),
                at: CGPoint(x: 0, y: 0),
                anchor: .topLeading
            )
            context.fill(
                Path(ellipseIn: CGRect(origin: .zero, size: CGSize(width: 100, height: 100))),
                with: .color(.pink)
            )
            context.draw(
                Image("Blob 1"),
                in: CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
            )
            context.draw(
                Image(systemName: "hexagon.fill"),
                in: CGRect(origin: .zero, size: size)
            )
        }
        .frame(width: 200, height: 212)
        .foregroundStyle(
            .linearGradient(
                colors: [.pink, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

struct HexogonView_Previews: PreviewProvider {
    static var previews: some View {
        HexagonView()
    }
}
