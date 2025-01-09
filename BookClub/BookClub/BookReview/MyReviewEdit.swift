// FILE : MyReviewEdit.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file defines the MyReviewEdit view, which allows users to edit their existing book reviews.
//               The view includes a "Save" button to persist changes to the Core Data context, dismissing the view upon successful save.

import SwiftUI
import CoreData

struct MyReviewEdit: View {
    @Environment(\.managedObjectContext) private var coreViewContext
    @ObservedObject var review: BReview
    @Environment(\.dismiss) var dismiss

    var ratings: [String] = ["1", "2", "3", "4", "5"]
    
    var body: some View {
        Form {
            Section(header: Text("Book information")) {
                HStack {
                    Label("", systemImage: "book")
                    TextField("Title", text: Binding(get: {review.title ?? ""},
                                                     set: {review.title = $0}))
                    
                }
                HStack {
                    Label("", systemImage: "person")
                    TextField("Author", text: Binding(get: {review.author ?? ""},
                                                      set: {review.author = $0}))
                }
                HStack {
                    Label("", systemImage: "tag")
                    TextField("Genre", text: Binding(get: {review.genre ?? ""},
                                                     set: {review.genre = $0}))
                }
                HStack {
                    Label("", systemImage: "star")
                    Picker("", selection: Binding(get: { review.rating },
                                                  set: { newValue in
                        review.rating = newValue
                    }
                                                 )) {
                        ForEach(ratings, id: \.self) { ratingValue in
                            Text(ratingValue).tag(ratingValue)
                        }
                    }
                                                 .pickerStyle(MenuPickerStyle())
                }
            } //Section end
            Section(header: Text("Summary")) {
                HStack {
                    Label("", systemImage: "quote.bubble")
                    TextEditor(text: Binding(get: {review.quotes ?? ""},
                                             set: {review.quotes = $0}))
                }
                HStack {
                    Label("", systemImage: "text.bubble")
                    TextEditor(text: Binding(get: {review.summary ?? ""},
                                             set: {review.summary = $0}))
                    .frame(height: 200)
                    .padding()
                }
            } //Section end
        }//Form end
        
        Button(action: {
            editReview()
        }) {
            Text("Save")
                .frame(maxWidth: 80)
                .padding()
                .background(.bubblegum)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
    }//Body end
    
    
    private func editReview() {
        withAnimation {
            do {
                try coreViewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

//#Preview {
//    MyReviewEdit()
//}
