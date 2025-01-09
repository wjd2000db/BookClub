//
// FILE          : ModelData
// PROJECT       : PROG3230 - Assignment #2
// PROGRAMMER    : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION   : This file defines the ModelData class, which is an observable object that manages a collection
//                 of book clubs loaded from a JSON file. It provides a method to load data from a specified
//                 file and decode it into a Swift structure.
//

import Foundation

//
// NAME     : ModelData
// PURPOSE  : This class serves as a data model for the application, managing a collection of book clubs.
//            It loads the book club data from a JSON file and publishes it for use in the UI.
//
class ModelData: ObservableObject {
    @Published var bookClubs: [BookClub] = load("ClubData.json")
    
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
