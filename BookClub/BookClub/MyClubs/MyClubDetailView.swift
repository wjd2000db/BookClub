//
// FILE          : MyClubDetailView
// PROJECT       : PROG3230 - Assignment #2
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION   : This file has the details of a specific book club.
//                 The view shows information such as the meeting date, time, location, the book being read, the author,
//                 additional notes, and the list of attendees. The main functionalities include displaying club details in
//                 a list format, presenting an edit view when the "Edit" button is tapped, and dynamically updating the
//                 attendee list to include "You" if the user is a member of the club.
// UPDATED VERSION: 2024-11-29 - CoreData is connected for A3

import SwiftUI

struct MyClubDetailView: View {
    @Environment(\.managedObjectContext)
    private var coreViewContext
    @ObservedObject var myClubs: MyClub

    @State private var isPresentingEditView = false     // control the presentation of the edit view
    @State var theDate = Date()
    @State var dateformatter = DateFormatter()
    
    var body: some View {
        List {
            Section(header: Text(LocalizedStringKey("ClubInfo"))){
                HStack {
                    Label("", systemImage: "suit.club")
                        .symbolRenderingMode(.multicolor)
                    Text(myClubs.name ?? "")
                }
                HStack {
                    Label("", systemImage: "clock")
                        .symbolRenderingMode(.multicolor)
//                     Text(myClubs.date ?? Date(), style: .date)
                    Text(myClubs.id ?? "")
                    
                }
                HStack {
                    Label("", systemImage: "location.fill")
                        .symbolRenderingMode(.multicolor)
                    Text(myClubs.location ?? "")
                }
                HStack {
                    Label("", systemImage: "books.vertical")
                        .symbolRenderingMode(.multicolor)
                    Text(myClubs.book ?? "")
                }
            }
            HStack {
                Label("", systemImage: "deskclock")
                    .symbolRenderingMode(.multicolor)
                Text(String(format: "%.0f Minutes", myClubs.bookmark))
            }
            Section(header: Text(LocalizedStringKey("Note"))) {
                VStack {
                    Text(myClubs.note ?? "")
                }
            }
        }
        .toolbar {
            Button("Edit") {
        
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                MyClubEditView(theclub: myClubs)
                    .navigationTitle(myClubs.name ?? "")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                
                            }
                        }
                    }
                }
        }
    }
}
