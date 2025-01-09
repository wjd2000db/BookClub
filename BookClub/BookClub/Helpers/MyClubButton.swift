// FILE : MyClubButton.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file completes the UI view with the button that represents the club join status.

import SwiftUI

struct MyClubButton: View {
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()

               } label: {
                   Text(isSet ? LocalizedStringKey("Joined") : LocalizedStringKey("Join Club"))
                       .padding(5.0)
                      .foregroundColor(.white)
                      .background(isSet ? Color(red: 100 / 255, green: 220 / 255, blue: 150 / 255) : Color(red: 80 / 255, green: 110 / 255, blue: 200 / 255))
                      .cornerRadius(8)
                      .bold()
               }
    }
}

#Preview {
    MyClubButton(isSet: .constant(false))
    MyClubButton(isSet: .constant(true))
}
