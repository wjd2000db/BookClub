// FILE : AddReviewView.swift
// PROJECT : PROG2030-Assignment #2 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 11/01/24
// DESCRIPTION :This file defines the AddReviewView struct, a SwiftUI view component in the BookClub app,
//              designed to facilitate user input for creating new book reviews. The view includes form fields
//              for entering book information, including title, author, genre, rating, reading periods, and review
//              details such as favorite quotes, a summary, and evaluations of plot and character development.
//              Users can enter details about their reading experience and save the review, which is then persisted
//              in the app’s managed object context (Core Data). The view leverages the @FetchRequest property wrapper
//              to display saved reviews, and the @Environment property wrapper for Core Data context and dismissal actions after saving.

import SwiftUI

struct AddReviewView: View {
    @Environment(\.managedObjectContext)
    private var coreViewContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath:
                                \BReview.title, ascending: true)], animation: .default)
    private var reviews: FetchedResults<BReview>
    
    @State private var booktitle = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = "1"
    @State private var startDate: Date = Date()
    @State private var finishDate: Date = Date()
    @State private var quotes = ""
    @State private var summary = ""
    @State private var plot = "Good"
    @State private var character = "Good"
    @State private var capturedImage: UIImage?
    @State private var showCameraView = false
    let developments = ["Poor", "Good", "Great"]
    let ratings: [String] = ["1", "2", "3", "4", "5"]
    
    var body: some View {
        NavigationView{
            
            VStack {
                Text(LocalizedStringKey("New Review"))
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Form {
                    Section(header: Text(LocalizedStringKey("Book Information"))) {
                        HStack {
                            Image(systemName: "book")
                            TextField(LocalizedStringKey("Title"), text: $booktitle)
                        }
                        
                        HStack {
                            Image(systemName: "person")
                            TextField(LocalizedStringKey("Author"), text: $author)
                        }
                        
                        HStack {
                            Image(systemName: "tag")
                            TextField(LocalizedStringKey("Genre"), text: $genre)
                        }
                        
                        HStack {
                            Image(systemName: "star")
                            Picker(LocalizedStringKey("Rating"), selection: $rating) {
                                ForEach(ratings, id: \.self) { ratingValue in
                                    Text("\(ratingValue)").tag(ratingValue)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    } //Section end
                    
                    Section(header: Text(LocalizedStringKey("Reading Periods"))) {
                        HStack {
                            Image(systemName: "calendar")
                            DatePicker(LocalizedStringKey("Start Date"), selection: $startDate, displayedComponents: .date)
                                .labelsHidden()
                        }
                        
                        HStack {
                            Image(systemName: "calendar")
                            DatePicker(LocalizedStringKey("Finish Date"), selection: $finishDate, displayedComponents: .date)
                                .labelsHidden()
                        }
                    } //Section end
                    
                    Section(header: Text(LocalizedStringKey("Review Details"))) {
                        HStack {
                            Image(systemName: "quote.bubble")
                            TextField(LocalizedStringKey("Quotes"), text: $quotes)
                        }
                        
                        HStack {
                            Image(systemName: "text.bubble")
                            TextField(LocalizedStringKey("Summary"), text: $summary)
                        }
                        
                        HStack {
                            Image(systemName: "doc.plaintext")
                            Picker(LocalizedStringKey("Plot Development"), selection: $plot) {
                                ForEach(developments, id: \.self) {
                                    Text($0)
                                }
                                .fixedSize(horizontal: false, vertical: true)
                            }
                            .pickerStyle(MenuPickerStyle())                    }
                        
                        HStack {
                            Image(systemName: "person.3")
                            Picker(LocalizedStringKey("Character Development"), selection: $character) {
                                ForEach(developments, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    } //Section end
                    
                    Section(header: Text(LocalizedStringKey("Photo"))) {
                        if let image = capturedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Text("No photo captured")
                                .foregroundColor(.gray)
                        }
                        
                        if capturedImage == nil {
                            Button(action: {
                                showCameraView.toggle()
                            }) {
                                Text(LocalizedStringKey("Add Photo"))
                                    .foregroundColor(.blue)
                            }
                            .sheet(isPresented: $showCameraView) {
                                CameraView(capturedImage: $capturedImage)
                            }
                        }
                    }

                    Button(action: {
                        addReview()
                    }) {
                        Text(LocalizedStringKey("Save"))
                            .frame(maxWidth: 100) 
                            .padding()
                            .background(Color.bubblegum)
                            .foregroundColor(.white)
                            .cornerRadius(50)
                    }
                    .frame(maxWidth: .infinity)
                }
        }
        
        
            
        } //body end
    }

    
    private func addReview() {
        withAnimation {
            let newReview = BReview(context: coreViewContext)
            newReview.title = booktitle
            newReview.author = author
            newReview.genre = genre
            newReview.rating = rating
            newReview.quotes = quotes
            newReview.summary = summary
            newReview.plot = plot
            newReview.character = character
            
            if let image = capturedImage, let imageData = image.jpegData(compressionQuality: 1.0) {
                       newReview.photo = imageData
                   }
            do {
                try coreViewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Error \(nsError), \(nsError.userInfo)")
            }
        }
    } //addReview end
}

#Preview {
    AddReviewView()
}
