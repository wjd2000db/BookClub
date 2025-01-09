//
// FILE          : ContentView
// PROJECT       : PROG3230 - Assignment #1
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-10-10
// DESCRIPTION   : This file provides a tabbed interface that allows users to switch between different views.
//                 The tabs include a list of all book clubs and a list of the clubs that the user has joined.
//
import SwiftUI

struct ContentView: View {
    @State private var menu: Tab = .home
    @EnvironmentObject var modelData: ModelData
    
    enum Tab {
        case home
        case list
        case collection
        case reviewlist
    }
    
    var body: some View {
        TabView(selection: $menu) {
            // View for all book clubs
            BookClubList()
                .tabItem {
                    Label("Club", systemImage: "house.fill")
                }
                .tag(Tab.home)

            // View for the list of the clubs details that the user has joined
//            MyClubListView(bookClubs: $modelData.bookClubs)
            MyClubListView()
                .tabItem {
                    Label("My Clubs", systemImage: "list.bullet")
                }
                .tag(Tab.list)
            
            MyReviewLIst()
                .tabItem {
                    Label("My Reviews", systemImage: "note.text")
                }
                .tag(Tab.collection)
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(ModelData())
}
