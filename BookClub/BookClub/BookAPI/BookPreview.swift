// FILE : BookPreview.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 11/28/24
// DESCRIPTION : Uses a WKWebView to display a web preview of a book's content based on a provided URL.

import SwiftUI
import WebKit

struct BookPreview: UIViewRepresentable {
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeUrlString = urlString {
            if let url = URL(string: safeUrlString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}


#Preview {
    BookPreview(urlString: "https://books.google.ca/books?id=oPHiDwAAQBAJ&printsec=frontcover&dq=Wonder+R.+J.+Palacio&hl=&cd=1&source=gbs_api#v=onepage&q=Wonder%20R.%20J.%20Palacio&f=false")
}
