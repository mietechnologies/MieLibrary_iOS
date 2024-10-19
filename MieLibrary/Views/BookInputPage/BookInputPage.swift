//
//  BookInputPage.swift
//  MieLibrary
//
//  Created by Brett Chapin on 10/17/24.
//

import SwiftUI

struct BookInputPage: View {
    @Environment(\.dismiss) var dismiss
    
    @State var vm: BookInputViewModel
    
    init(book: Book? = nil) {
        _vm = .init(initialValue: .init(book: book))
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .foregroundStyle(Color.main)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                
                Text("\(vm.book?.title ?? "New Book")")
                    .themeStyle(.header)
                    .padding(.bottom, 8)
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    TitledTextField("Title", text: $vm.title)
                    
                    TitledTextField("Subtitle", text: $vm.subtitle)
                    
                    TitledTextField("Author", text: $vm.author)
                    
                    TitledTextField("Number of Pages", text: $vm.numberOfPagesRaw)
                        .keyboardType(.numberPad)
                    
                    TitledTextField("Series", text: $vm.series)
                    
                    TitledTextField("Series", text: $vm.seriesNumberRaw)
                        .keyboardType(.numberPad)
                    
                    TagsView {
                        ForEach(vm.tags, id: \.self) { tag in
                            let viewWidth = tag.size(.preferredFont(forTextStyle: .body)).width + 24
                            
                            Text(tag)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .background(Color.tertiary, in: Capsule())
                                .containerValue(\.viewWidth, viewWidth)
                                .onTapGesture {
                                    vm.removeTag(tag)
                                }
                        }
                    }
                    
                    TitledTextField("Add Tag", text: $vm.inputTag) {
                        vm.addTag()
                    }
                    
                    TitledTextField("Publisher", text: $vm.publisher)
                    
                    DatePicker("Published Date", selection: $vm.publishedDate, displayedComponents: .date)
                        .themeStyle(.subheader)
                        .padding(.vertical, 8)
                    
                    TitledTextField("ISBN", text: $vm.isbn)
                    
                    Button {
                        if vm.book != nil {
                            vm.updateBook()
                        }
                        dismiss()
                    } label: {
                        Text("Save")
                            .themeStyle(.button)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 48)
                    }
                    .background(Color.accented, in: RoundedRectangle(cornerRadius: 8))
                    .padding(.top, 24)
                    .padding(.bottom, 32)
                    
                }
                .padding(.all)
            }
            .scrollIndicators(.hidden)
            
        }
        .background(Color.background)
        .ignoresSafeArea()
    }
}

#Preview {
    BookInputPage(book:
                    Book(
                        title: "Lord of the Rings",
                        subTitle: "Fellowship of the Rings",
                        author: "J.R.R Tolkein",
                        publisher: "Houghton Miffin",
                        publishedDate: .init(),
                        numberOfPages: 423,
                        genre: .fantasy(.high),
                        series: "Lord of the Rings",
                        seriesNumber: 1,
                        isbn: "1234567890",
                        bookCover: "Fellowship",
                        tags: ["frodo", "tolkein", "middle-earth"]
                    )
    )
}
