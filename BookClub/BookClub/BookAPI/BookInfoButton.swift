// FILE : BookInfoButton.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 11/28/24
// DESCRIPTION : Provides a button to fetch book information based on a title and author.
//              Upon clicking the button, it sends a network request using NetworkManager
//              to retrieve matching books and navigates to the APISearchView to display
//              the results. The file also includes a preview setup for testing the button with sample data.

import SwiftUI

struct BookInfoButton: View {
    let bookTitle: String
    let authorName: String
    
    @State private var navigateToResults = false
    @StateObject private var networkManager = NetworkManager()
    var body: some View {
        NavigationStack {
                Button(action: {
                    let query = "\(bookTitle) \(authorName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    networkManager.fetchData(query: query)
                    navigateToResults = true
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle())
                .navigationDestination(isPresented: $navigateToResults) {
                    APISearchView(books: networkManager.books)
            }
            
        }
    }
}

#Preview {
    BookInfoButton(bookTitle: "Wonder", authorName: "R.J. Palacio")
}

