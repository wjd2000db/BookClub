// FILE : BookClubDetail.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 11/01/24
// DESCRIPTION : This file completes the UI view with the book club information and club data, such as image, title, description, and map.

import SwiftUI

struct BookClubDetail: View {
    @EnvironmentObject var modelData: ModelData
    var bookclub: BookClub
    
    var bookClubIndex: Int {
        modelData.bookClubs.firstIndex(where: { $0.id == bookclub.id })!
       }
    
    @State private var isLoading = true
    
    @Environment(\.managedObjectContext) private var coreViewContext
    @Environment(\.dismiss) var dismiss
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath:
                                \MyClub.name, ascending: true)], animation: .default)
    private var reviews: FetchedResults<MyClub>
    
    @State private var isMyClub = false
    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                ScrollView {
                    Text(LocalizedStringKey("Introduction"))
                        .font(.title3)
                        .bold()
                    TitleImage(image: bookclub.image)
                        .offset(y: 10)
                    
                    HStack {
                        Text(bookclub.book)
                            .font(.title)
                        BookInfoButton(
                            bookTitle: bookclub.book,
                            authorName: bookclub.author
                        )
                        .frame(width: 20, height: 20)
                        .padding(.leading, 8)
                    }
                    .padding(.top, 30)
                    
                    Text(bookclub.author)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    MyClubButton(isSet: $modelData.bookClubs[bookClubIndex].isMyClub)
                    
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(LocalizedStringKey("Date")).bold()
                            Text(bookclub.date).padding(.leading, 40)
                        }
                        HStack {
                            Text(LocalizedStringKey("Time")).bold()
                            Text(bookclub.time).padding(.leading, 40)
                        }
                        HStack {
                            Text(LocalizedStringKey("Location")).bold()
                            Text(" ")
                            Text(bookclub.library)
                        }
                        
                        Divider()
                        
                        Text(bookclub.description)
                        
                        Divider()
                        
                        if bookclub.library != "online" {
                            MapView(coordinate: bookclub.locationCoordinate)
                                .frame(height: 200)
                        }

                    }
                    .padding()
                }
                .navigationTitle(bookclub.name)
                .navigationBarTitleDisplayMode(.inline)
                .onChange(of: modelData.bookClubs[bookClubIndex].isMyClub) {
                    if modelData.bookClubs[bookClubIndex].isMyClub == true {
                        // add to the core data
                        addMyClub()
                    } else {
                        // remove the club from the core data
                        print("bye")
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
            }
        }
    }
    
    private func addMyClub() {
        withAnimation {
            let newMyClub = MyClub(context: coreViewContext)
            newMyClub.name = bookclub.name
            newMyClub.id = bookclub.date + " " + bookclub.time
            newMyClub.date = Date()
            newMyClub.location = bookclub.library
            newMyClub.note = "please enter"
            newMyClub.book = bookclub.book
            newMyClub.imgname = "image name"
            newMyClub.bookmark = 0
            do {
                try coreViewContext.save()
                dismiss()
            } catch {
                let nsError = error as NSError
                fatalError("Error \(nsError), \(nsError.userInfo)")
            }
            print("addMyClub-\(bookclub.name)")
        }
    }
    
}



#Preview {
    let modelData = ModelData()
    BookClubDetail(bookclub: ModelData().bookClubs[0])
        .environmentObject(modelData)
}
