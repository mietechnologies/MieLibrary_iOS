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
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithTransparentBackground()
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.text]
        tabAppearance.stackedLayoutAppearance.normal.iconColor = .text
        tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.highlight]
        tabAppearance.stackedLayoutAppearance.selected.iconColor = .highlight
        UITabBar.appearance().standardAppearance = tabAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        UITabBar.appearance().barTintColor = .main
        UITabBar.appearance().backgroundColor = .main
        
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithTransparentBackground()
        navAppearance.backgroundColor = .main
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.text]
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor.text]
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().standardAppearance = navAppearance
        
    }

    var body: some View {
        TabView {
            Tab("Home", systemImage: "books.vertical.fill") {
                NavigationSplitView { // TODO: Update this to a NavigationStack
                    ScrollView {
                        LazyVGrid(
                            columns: [
                                .init(.flexible(), spacing: 10, alignment: .center),
                                .init(.flexible(), spacing: 10, alignment: .center),
                                .init(.flexible(), spacing: 10, alignment: .center),
                                .init(.flexible(), spacing: 10, alignment: .center),
                                .init(.flexible(), spacing: 10, alignment: .center)
                            ],
                            alignment: .center,
                            spacing: 10,
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
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(Color.text)
                                    .accessibilityLabel("Search")
                            }
                        }
                        ToolbarItem {
                            Button(action: addItem) {
                                Image(systemName: "plus")
                                    .foregroundStyle(Color.text)
                                    .accessibilityLabel("Add Item")
                                    
                            }
                        }
                    }
                    .navigationTitle("Library")
                } detail: {
                    Text("Select an item")
                }
            }
            
            Tab("Settings", systemImage: "gear") {
                NavigationSplitView { // TODO: Update this to a NavigationStack
                    VStack {
                        Text("Hello")
                    }
                    .navigationTitle("Settings")
                } detail: {
                    Text("Settings")
                }
            }
        }
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
