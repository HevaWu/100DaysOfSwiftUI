//
//  ContentView.swift
//  Bookworm
//
//  Created by He Wu on 2021/10/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddBook = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating == 1 ? .red : .black)
                            
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationBarTitle("Bookworm")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(action: {
                        showingAddBook.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                )
                .sheet(isPresented: $showingAddBook) {
                    AddBookView().environment(\.managedObjectContext, moc)
                }

        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
