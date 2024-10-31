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
    var addBook: ((Book) -> Void)?
    
    init(book: Book? = nil, addBook: ((Book) -> Void)? = nil) {
        _vm = .init(initialValue: .init(book: book))
        self.addBook = addBook
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .foregroundStyle(Color.main)
                    .frame(height: 80)
                    .frame(maxWidth: .infinity)
                
                Text("\(vm.book?.title ?? "New Book")")
                    .themeStyle(.header)
                    .padding(.bottom, 8)
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    TitledTextField("Title", text: $vm.title, titleColor: (vm.showMissingFields && vm.title.isEmpty) ? .highlight : .text)
                    
                    TitledTextField("Subtitle", text: $vm.subtitle)
                    
                    TitledTextField("Author First Name", text: $vm.authorFirstName)
                    
                    TitledTextField("Author Last Name", text: $vm.authorLastName, titleColor: (vm.showMissingFields && vm.authorLastName.isEmpty) ? .highlight : .text)
                    
                    HStack(alignment: .center) {
                        Text("Genre")
                            .themeStyle(.subheader, fontColor: (vm.showMissingFields && vm.genre == nil) ? .highlight : .text)
                        
                        Spacer()
                        
                        Menu {
                            Picker("Genre", selection: $vm.genre) {
                                ForEach(GenreType.allCases, id: \.self) { genre in
                                    Text(genre.rawValue)
                                        .themeStyle(.body)
                                        .tag(genre)
                                }
                            }
                        } label: {
                            Text(vm.genre?.rawValue ?? "No Genre Selected")
                                .themeStyle(.body, fontColor: .accented)
                        }
                    }
                    
                    TitledTextField("Series", text: $vm.series)
                    
                    TitledTextField("# in Series", text: $vm.seriesNumber, titleType: .horizontal)
                        .keyboardType(.numberPad)
                    
                    TitledTextField("# of Pages", text: $vm.numberOfPages, titleType: .horizontal)
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
                    
                    DatePicker("Published Date", selection: Binding<Date>(get: {vm.publishedDate ?? Date()}, set: {vm.publishedDate = $0}), displayedComponents: .date)
                        .themeStyle(.subheader)
                        .padding(.vertical, 8)
                    
                    TitledTextField("ISBN", text: $vm.isbn)
                    
                    Button {
                        if vm.book != nil {
                            vm.updateBook()
                        }
                        
                        if let addBook, let book = vm.constructBook() {
                            addBook(book)
                        }
                        
                        if !vm.showMissingFields {
                            dismiss()
                        }
                    } label: {
                        Text(vm.book != nil ? "Save" : "Add")
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
                        authorFirstName: "J.R.R.",
                        authorLastName: "Tolkein",
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
