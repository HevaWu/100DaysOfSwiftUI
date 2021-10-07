//
//  DetailView.swift
//  Bookworm
//
//  Created by He Wu on 2021/10/06.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showDeleteAlert = false
    
    var book: Book
    
    var formatDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = book.date {
            return dateFormatter.string(from: date)
        } else {
            return "Unknown date"
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    
                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                Text("Date: \(formatDate)")
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete Book"),
                message: Text("Are you sure?"),
                primaryButton: .destructive(
                    Text("Delete"),
                    action: {
                        deleteBook()
                    }),
                secondaryButton: .cancel()
            )
        }
        .navigationBarItems(
            trailing: Button(action: {
                showDeleteAlert = true
            }, label: {
                Image(systemName: "trash")
            })
        )
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book!!!"
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
