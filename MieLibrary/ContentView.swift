//
//  ContentView.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/7/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Color.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Color.white]
    }

    var body: some View {
        TabView {
            Tab("Home", systemImage: "books.vertical.fill") {
                NavigationSplitView {
                    ScrollView {
                        LazyVGrid(
                            columns: [
                                .init(.flexible(), spacing: 8, alignment: .center),
                                .init(.flexible(), spacing: 8, alignment: .center),
                                .init(.flexible(), spacing: 8, alignment: .center),
                                .init(.flexible(), spacing: 8, alignment: .center),
                                .init(.flexible(), spacing: 8, alignment: .center)
                            ],
                            alignment: .center,
                            spacing: 8,
                            content: {
                                ForEach(0..<47, id: \.self) { _ in
                                    let bookNumber = Int.random(in: 0...4)
                                    Image("Test Book \(bookNumber)")
                                        .resizable()
                                        .scaledToFit()
                                }
                            })
                        .padding(8)
                        
                        Text("47 Books")
                            .font(.headline)
                            .foregroundStyle(Color.tertiary)
                            .padding(.bottom, 8)
                    }
                    .background(Color.background)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                print("Search Tapped")
                            } label: {
                                Label("Search", systemImage: "magnifyingglass")
                                    .foregroundStyle(.text, .highlight)
                            }
                        }
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                                    .foregroundStyle(.text, .highlight)
                            }
                        }
                    }
                    .navigationTitle("Library")
                    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                    .toolbarBackground(Color.main, for: .navigationBar)
                    .tabViewStyle(.tabBarOnly)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .toolbarBackground(Color.main, for: .tabBar)
                } detail: {
                    Text("Select an item")
                }
            }
            
            Tab("Settings", systemImage: "gear") {
                NavigationSplitView {
                    VStack {
                        Text("Hello")
                    }
                    .navigationTitle("Settings")
                    .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                    .toolbarBackground(Color.main, for: .navigationBar)
                    .tabViewStyle(.tabBarOnly)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                    .toolbarBackground(Color.main, for: .tabBar)
                } detail: {
                    Text("Settings")
                }
            }
        }
        .tint(Color.highlight)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
