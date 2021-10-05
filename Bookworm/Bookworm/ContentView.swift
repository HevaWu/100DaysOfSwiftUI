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
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddBook = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink {
                        Text(book.title ?? "Unknown Title")
                    } label: {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
                .navigationBarTitle("Bookworm")
                .navigationBarItems(
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
