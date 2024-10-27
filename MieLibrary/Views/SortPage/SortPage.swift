//
//  SortPage.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/25/24.
//

import SwiftUI

struct SortPage: View {
    
    @Binding var selection: SortingCategory
    @Binding var order: SortOrder
    
    let sortOptions: [SortOrder] = [.forward, .reverse]
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack(alignment: .bottom) {
                    Rectangle()
                        .foregroundStyle(Color.main)
                        .frame(height: 80)
                        .frame(maxWidth: .infinity)
                    
                    Text("Options")
                        .themeStyle(.header)
                        .padding(.bottom, 8)
                }
                
                SortingHeaderView()
                    .padding(.top)
                
                ForEach(SortingCategory.allCases) { option in
                    SortingOptionToggle("By \(option.rawValue)", isOn: toggleBinding(for: option))
                }
                
                OrderHeaderView()
                
                HStack {
                    ForEach(sortOptions, id: \.self) { order in
                        OrderOptionToggle(order == .forward ? "Forward" : "Reverse", isOn: orderToggleBinding(for: order))
                    }
                }
                
                Spacer()
            }
        }
        .background(Color.background)
    }
    
    private func toggleBinding(for category: SortingCategory) -> Binding<Bool> {
        Binding {
            self.selection == category
        } set: { _ in
            selection = category
        }
    }
    
    private func orderToggleBinding(for order: SortOrder) -> Binding<Bool> {
        Binding {
            self.order == order
        } set: { _ in
            self.order = order
        }
    }
    
    private func SortingHeaderView() -> some View {
        VStack {
            HStack {
                Text("Sort Books")
                    .themeStyle(.subheader)
                
                Spacer()
                
                Text("Selection")
                    .themeStyle(.subheader)
            }
            .padding(.horizontal)
            
            Divider()
        }
    }
    
    private func OrderHeaderView() -> some View {
        VStack {
            HStack {
                Text("Order Books")
                    .themeStyle(.subheader)
            }
            
            Divider()
        }
    }
    
    private func SortingOptionToggle(_ sortMethod: String, isOn: Binding<Bool>) -> some View {
        HStack(alignment: .center) {
            Text(sortMethod)
                .themeStyle(.body)
            
            Spacer()
            
            Toggle("", isOn: isOn)
                .toggleStyle(.checkboxToggle)
        }
        
        .padding(.horizontal)
        .padding(.top, 12)
    }
    
    private func OrderOptionToggle(_ orderOption: String, isOn: Binding<Bool>) -> some View {
        VStack(alignment: .center) {
            Text(orderOption)
                .themeStyle(.body)
            
            Toggle("", isOn: isOn)
                .toggleStyle(.checkboxToggle)
        }
        .padding(.horizontal)
    }
}
