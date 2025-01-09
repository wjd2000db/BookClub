// FILE : MyReviewList.swift
// PROJECT : PROG2030-Assignment #3 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file defines the MyReviewList view, which displays a list of book reviews fetched from Core Data.
//              Users can navigate to detailed views of each review, delete reviews using swipe actions, and add new reviews
//              via a dedicated button.

import SwiftUI

struct MyReviewLIst: View {
    @Environment(\.managedObjectContext)
    private var coreViewContext
    
    @FetchRequest(
        sortDescriptors:
            [NSSortDescriptor(keyPath:
                                \BReview.title, ascending: true)], animation: .default)
    private var reviews: FetchedResults<BReview>
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(reviews) { rv in
                    NavigationLink(destination: MyBookReviewDetail(bookReview:rv)) {
                        Text("\(rv.title!)")
                    }
                }
                .onDelete(perform: deleteReview(offsets:))
            }.navigationBarTitle("My Reviews")
                .toolbar {
                    EditButton()
                }
            
            NavigationLink(destination: AddReviewView()) {
                Text("Add")
                    .frame(maxWidth: 80)
                    .padding()
                    .background(Color.bubblegum)
                    .foregroundColor(.white)
                    .cornerRadius(50)
                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
            }
            .padding()
        }//NavigationStack end
    } //body end
    
    private func addReview() {
        withAnimation {
            let newReview = BReview(context: coreViewContext)
            newReview.title = "new title"
            do {
                try coreViewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteReview(offsets: IndexSet) {
        offsets.map {
            reviews[$0]
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
    MyReviewLIst()
}
