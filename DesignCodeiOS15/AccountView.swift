//
//  AccountView.swift
//  DesignCodeiOS15
//
//  Created by Aleksei Sobolevskii on 2022-09-02.
//

import SwiftUI

struct AccountView: View {
    @State private var isDeleted = false

    var body: some View {
        NavigationView {
            List {
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.badge.checkmark")
                        .symbolVariant(.circle.fill)
                        .font(.system(size: 32))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.blue, .blue.opacity(0.3))
                        .padding()
                        .background(Circle().fill(.ultraThinMaterial))
                        .background(
                            Image(systemName: "hexagon")
                                .symbolVariant(.fill)
                                .foregroundColor(.blue)
                                .font(.system(size: 200))
                                .offset(x: -50, y: -100)
                        )
                    Text("Aleksei Sobolevskii")
                        .font(.title.weight(.semibold))
                    HStack {
                        Image(systemName: "location")
                            .imageScale(.small)
                        Text("Canada")
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()

                Section {
                    NavigationLink {
                        ContentView()
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                    NavigationLink {
                        Text("Billing")
                    } label: {
                        Label("Billing", systemImage: "creditcard")
                    }
                    NavigationLink {
                        ContentView()
                    } label: {
                        Label("Help", systemImage: "questionmark")
                    }
                }
                .accentColor(.primary)
                .listRowSeparatorTint(.blue)
                .listRowSeparator(.automatic)

                Section {
                    if isDeleted == false {
                        Link(destination: URL(string: "https://apple.com")!) {
                            HStack {
                                Label("Website", systemImage: "house")
                                Spacer()
                                Image(systemName: "link")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(action: { isDeleted = true }) {
                                Label("Delete", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {

                            } label: {
                                Label("Pin", systemImage: "pin")
                            }
                            .tint(.yellow)
                        }
                    }
                    Link(destination: URL(string: "https://youtube.com")!) {
                        HStack {
                            Label("Youtube", systemImage: "tv")
                            Spacer()
                            Image(systemName: "link")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .accentColor(.primary)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
