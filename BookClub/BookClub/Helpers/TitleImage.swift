// FILE : MyClubButton.swift
// PROJECT : PROG2030-Assignment #2 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file completes the UI with the image component according to the image name of JSON data attributes.

import SwiftUI

struct TitleImage: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: 200, height: 250)
            .overlay{
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 5)
    }
}

#Preview {
    TitleImage(image: Image("wonder"))
}
