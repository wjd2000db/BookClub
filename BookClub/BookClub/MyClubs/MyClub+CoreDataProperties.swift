//
//  MyClub+CoreDataProperties.swift
//  BookClub
//
//  Created by Yujung Park on 2024-12-01.
//
//

import Foundation
import CoreData


extension MyClub {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyClub> {
        return NSFetchRequest<MyClub>(entityName: "MyClub")
    }

    @NSManaged public var book: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var imgname: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var bookmark: Double

}

extension MyClub : Identifiable {

}
