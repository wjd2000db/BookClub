//
// FILE          : MyClubEditView
// PROJECT       : PROG3230 - Assignment #2
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION   : This file allows users to edit the details of a specific book club, including the
//                 bookmark page, and any notes associated with the book club. The view includes
//                 a text field for the book title, a slider for selecting the current reading
//                 page, and a text editor for writing notes.
// UPDATED VERSION: 2024-11-29 - CoreData is connected for A3

import SwiftUI

struct MyClubEditView: View {
    @Environment(\.managedObjectContext) private var coreViewContext
    @ObservedObject var theclub: MyClub
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack{
            Form {
                Section(header: Text("My Club")) {
                    HStack {
                        Label("", systemImage: "suit.club.fill")
                        Text(theclub.name ?? "")
                    }
                    Label("Meetup Duration", systemImage: "deskclock.fill")
                    HStack {
                        Slider(
                            value: $theclub.bookmark,
                            in: 0...120,
                            step: 5, label: {
                            Text("text")
                        }, minimumValueLabel: {
                            Text("1")
                                .font(.headline)
                        }, maximumValueLabel: {
                            Text("120")
                                .font(.headline)
                        })
                    }
                    VStack {
                        Text(String(format: "%.0f Minutes", theclub.bookmark))
                    }
                }
                Section(header: Text("Note")) {
                    TextEditor(text: Binding(get: {theclub.note ?? ""},
                                             set: {theclub.note = $0}))
                    .frame(height: 200)
                    .padding(1)
                }
            } // end Form
                
            Button(action: {
                editClub()
            }) {
                Text("Save")
                    .frame(maxWidth: 80)
                    .padding()
                    .background(.bubblegum)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
        } // end VStack
        .navigationTitle("Edit Note")
    } // end View
    
    private func editClub() {
        withAnimation {
            do {
                try coreViewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

//#Preview {
//    let bookClub = ModelData().bookClubs[0]
//    MyClubEditView(bookclub: .constant(bookClub))
//}
