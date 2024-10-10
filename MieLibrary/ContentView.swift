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
    @Query(sort: [SortDescriptor(\Book.title, order: .forward), SortDescriptor(\Book.subTitle, order: .forward)]) private var books: [Book]
    
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
                                ForEach(books) { book in
                                    Image(book.bookCover ?? "No Cover")
                                        .resizable()
                                        .scaledToFit()
                                }
                            })
                        .padding(8)
                        
                        Text("\(books.count) Books")
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
                            Button {
                                print("Add Book Tapped")
                            } label: {
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
}

#Preview {
    ContentView()
        .modelContainer(sampleData)
}
