//
// FILE          : CulcureClubApp
// PROJECT       : PROG3230 - Assignment #1
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-10-10
// DESCRIPTION   : This file initializes the app and sets the main window with ContentView,
//                 injecting the ModelData environment object for use throughout.
import SwiftUI

@main
struct BookClubApp: App {
    @StateObject private var modelData = ModelData()
    let persistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
