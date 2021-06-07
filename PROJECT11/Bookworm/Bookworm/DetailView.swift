//
//  DetailView.swift
//  Bookworm
//
//  Created by Melo, Lareen on 6/5/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Unknown"]

    // 3
    var formattedString: String {
        if let date = book.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, d MMM yyyy h:mm a"
            
            return formatter.string(from: date)

        } else {
            return "N/A"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(genre(self.book.genre)) // 1
                        .frame(maxWidth: geometry.size.width)

                    Text(genre(self.book.genre).uppercased()) // 1
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                // 3
                Text("Added on " + formattedString)
                    .foregroundColor(.secondary)

                Text(self.book.review ?? "No review")
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)

                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                }, secondaryButton: .cancel()
            )
        }
    }
    
    // 1
    func genre(_ text: String?) -> String {
        guard let genre = text else { return "Unknown" }
        if genres.contains(genre) {
            return genre
        } else {
            return "Unknown"
        }
    }
    
    func deleteBook() {
        moc.delete(book)

        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.author = "Test Author"
        book.genre = "Fantasy"
        book.title = "Test Book"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
