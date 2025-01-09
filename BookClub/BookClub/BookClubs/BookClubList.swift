// FILE : BookClubList.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 11/01/24
// DESCRIPTION : This file completes the UI view with the BookClubRow component in the list view. The view is available to list the whole club list or the user's joined club using the toggle button.

import SwiftUI

struct BookClubList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showMyClubOnly = true
    @State private var isLoading = true
    
    
    var filteredBookClubs: [BookClub] {
        modelData.bookClubs.filter {bookclub in
                (!showMyClubOnly || bookclub.isMyClub)}
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                Toggle(isOn: $showMyClubOnly) {
                    Text(LocalizedStringKey("ToggleBtn"))
                }
                ForEach(filteredBookClubs){ bookclub in
                    NavigationLink {
                        BookClubDetail(bookclub: bookclub)
                    } label: {
                        BookClubRow(bookclub: bookclub)
                    }
                }
            }
            .animation(.default, value: filteredBookClubs)
            .navigationTitle(LocalizedStringKey("MainTitle"))
        } detail: {
            Text("Select a Book club")
        }
       
    }
}

#Preview {
    BookClubList()
        .environmentObject(ModelData())
}
