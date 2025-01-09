//
// FILE          : MyClubView
// PROJECT       : PROG3230 - Assignment #2
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION   : This file has a single book club in a view format. It displays the club's name,
//                 attendee count, and meeting time,styled according to the club's theme.
// UPDATED VERSION: 2024-11-29 - CoreData is connected for A3

import SwiftUI

struct MyClubView: View {
    let bookclub: BookClub
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(bookclub.name)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                // If the club is a club the user has joined, increment the attendee count by 1
                let attendeeCount = bookclub.isMyClub ? bookclub.attendees.count + 1 : bookclub.attendees.count
                Label("\(attendeeCount)", systemImage: "person.3")

                Spacer()
                Label("\(bookclub.date)", systemImage: "calendar")
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(bookclub.theme.accentColor)
        .background(bookclub.theme.mainColor)
    }
}

#Preview {
    let bookClubs = ModelData().bookClubs
    MyClubView(bookclub: bookClubs[0])
}
