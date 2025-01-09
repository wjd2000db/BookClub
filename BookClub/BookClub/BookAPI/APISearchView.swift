// FILE : APISearchView.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 11/28/24
// DESCRIPTION : Displays detailed information about books, including title, authors,
//               description, and a preview link. It uses a list to present book details
//               and allows navigation to a preview page via a link. The file also includes
//               a preview using sample book data for development purposes.

import SwiftUI

struct APISearchView: View {
    let books: [Book]
        
    var body: some View {
        NavigationView {
            List(books) { book in
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text(book.volumeInfo.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .lineLimit(2) 
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if let publishedDate = book.volumeInfo.publishedDate {
                            Text(publishedDate)
                                .font(.title3)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if let authors = book.volumeInfo.authors {
                        Text("by " + authors.joined(separator: ", "))
                            .font(.title3)
                            .foregroundColor(.secondary)
                            .padding(.top, 5)
                    }
                    
                    Divider()
                    
                    Text("Description")
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    
                    if let description = book.volumeInfo.description {
                        Text(description)
                            .font(.body)
                            .foregroundColor(.primary)
                            .lineSpacing(10)
                            .padding(.horizontal, 10)
                    }
                    
                    if let previewLink = book.volumeInfo.previewLink {
                        NavigationLink(destination: BookPreview(urlString: previewLink)) {
                            Text("Preview this book")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .padding(.top, 5)
                        }
                    }
                    
                    Divider()
                        .padding(.top, 15)
                }
            }
            .navigationTitle("Detail of the Book")
            .listStyle(PlainListStyle())
        }
    }
}

#Preview {
    let sampleBooks = [
        Book(
            id: "sample",
            kind: "books#volume",
            volumeInfo: VolumeInfo(
                title: "Sample Book 1",
                authors: ["Author 1", "Author 2"],
                description: "sample book",
                publishedDate: "2024-01-01",
                previewLink: "https://www.google.com"
            )
        ),
    ]
    
   APISearchView(books: sampleBooks)
}

