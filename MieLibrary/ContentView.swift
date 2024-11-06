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
    @State private var appSettings: AppSettings = .init()
    
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
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .background
    }

    var body: some View {
        TabView {
            Tab("Library", systemImage: "books.vertical.fill") {
                LibraryPage(sorting: $appSettings.sortMethod, order: $appSettings.sortOrder, addBook: { book in
                    modelContext.insert(book)
                })
                .modelContext(modelContext)
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
