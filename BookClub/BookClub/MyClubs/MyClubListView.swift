//
// FILE          : MyClubListView
// PROJECT       : PROG3230 - Assignment #2
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION   : This file has a list of book clubs that belong to the user.
//                 When a club is clicked, it navigates to the MyClubDetailView for more
//                 information about the selected club.
// UPDATED VERSION: 2024-11-29 - CoreData is connected for A3


import SwiftUI

struct MyClubListView: View {
    @Environment(\.managedObjectContext) private var coreViewContext
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath:
                                \MyClub.name, ascending: true)], animation: .default)
    private var clubs: FetchedResults<MyClub>
    
    
    // @Binding var bookClubs: [BookClub]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(clubs) { c in
                    NavigationLink(destination: MyClubDetailView(myClubs: c)) {
                        Text("\(c.name!)")
                    }
                }.onDelete(perform: deleteClub(offsets:))
            }
            .navigationTitle(LocalizedStringKey("My Clubs"))
            
        }
    }
    
    private func deleteClub(offsets: IndexSet) {
        offsets.map {
            clubs[$0]
        }.forEach(coreViewContext.delete)
        do {
            try coreViewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    MyClubListView()
}
