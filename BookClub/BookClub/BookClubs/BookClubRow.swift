// FILE : BookClubRow.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file completes the Ui view with bookclub image and club name with club join information.

import SwiftUI

struct BookClubRow: View {
    var bookclub: BookClub
    var body: some View {
        HStack {
            bookclub.image
                .resizable()
                .frame(width: 60, height: 60)
    
            Text(bookclub.name)
            
            Spacer()
            
            if bookclub.isMyClub {
                Text(LocalizedStringKey("Joined"))
                    .padding(3.0)
                   .foregroundColor(.white)
                   .background(Color(red: 100 / 255, green: 220 / 255, blue: 150 / 255))
                   .cornerRadius(8)
                   .bold()
            }
        }
    }
}

#Preview {
    let bookClubs = ModelData().bookClubs
    Group{
        BookClubRow(bookclub: bookClubs[0])
        BookClubRow(bookclub: bookClubs[1])
    }
 
}
