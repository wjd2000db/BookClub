// FILE : MyBookReviewDetail.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file defines the MyBookReviewDetail view, which displays detailed information about a specific book review.
//               The view also includes a navigation link to edit the review using the MyReviewEdit view, allowing users to modify their existing reviews.


import SwiftUI
import CoreData

struct MyBookReviewDetail: View {
    @Environment(\.managedObjectContext)
    private var coreViewContext
    @ObservedObject var bookReview: BReview
    
    func getImage(from data: Data?) -> UIImage? {
            guard let data = data else { return nil }
            return UIImage(data: data)
    }
    
    var body: some View {
        NavigationStack{
            List {
                Section(header: Text("Book")){
                    HStack {
                        Label("", systemImage: "book.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(bookReview.title ?? "")
                    }
                    HStack {
                        
                        Label("", systemImage: "person.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(bookReview.author ?? "")
                    }
                    HStack {
                        
                        Label("", systemImage: "tag.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(bookReview.genre ?? "")
                    }
                    HStack {
                        
                        Label("", systemImage: "star.fill")
                            .symbolRenderingMode(.multicolor)
                        Text(bookReview.rating ?? "")
                    }
                }
                Section(header: Text("Note")) {
                    HStack {
                        Label("", systemImage: "quote.bubble.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("Favorite Quote")
                    }
                    Text(bookReview.quotes ?? "")
                    HStack {
                        Label("", systemImage: "text.bubble.fill")
                            .symbolRenderingMode(.multicolor)
                        Text("summary")
                    }
                    Text(bookReview.summary ?? "")
                }
                
                Section(header: Text("Photo")) {
                    if let imageData = bookReview.photo, let uiImage = getImage(from: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        Text("No Photo")
                            .foregroundColor(.gray)
                    }
                }
            }//List end
            .navigationTitle("My Review")
            .toolbar {
                NavigationLink(destination: MyReviewEdit(review: bookReview)) {
                    Label("Edit", systemImage: "pencil")
                }
            }
        }//NavigationStack end
    }//view end
}
