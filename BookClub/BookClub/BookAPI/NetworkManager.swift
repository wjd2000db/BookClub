// FILE : NetworkManager.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 11/28/24
// DESCRIPTION :Manages network requests to fetch book data from the Google Books API. The class,
//              conforming to ObservableObject, publishes states such as the fetched books, navigation control,
//              and loading status. It includes a fetchData method to send requests using URLSession, decode
//              the JSON response, and update the books array with the results.

import Foundation

class NetworkManager: ObservableObject {
    @Published var books = [Book]()
    @Published var navigateToResults = false
    @Published var isLoading: Bool = false
    
    func fetchData(query: String) {
        self.isLoading = true
        if let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(query)&maxResults=1&projection=lite") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in

                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    if error == nil, let safeData = data {
                        let decoder = JSONDecoder()
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            self.books = results.items ?? []
                        } catch {
                            print("Failed to decode data: \(error)")
                        }
                    } else {
                        print("Error fetching data: \(String(describing: error))")
                    }
                }
            }
            task.resume()
        }
    }
}
