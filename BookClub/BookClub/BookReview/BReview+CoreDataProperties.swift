// FILE : BReview_CoreDataProperties.swift
// PROJECT : PROG2030-Assignment #2 - BookClub
// PROGRAMMER : Yujin Jeong, Yujung Park
// FIRST VERSION : 2024-11-01
// DESCRIPTION : This file contains the properties and fetch request definition for the BReview Core Data entity.


import Foundation
import CoreData


extension BReview {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BReview> {
        return NSFetchRequest<BReview>(entityName: "BReview")
    }

    @NSManaged public var author: String?
    @NSManaged public var title: String?
    @NSManaged public var character: String?
    @NSManaged public var genre: String?
    @NSManaged public var finish: Date?
    @NSManaged public var plot: String?
    @NSManaged public var rating: String?
    @NSManaged public var start: Date?
    @NSManaged public var summary: String?
    @NSManaged public var quotes: String?
    @NSManaged public var photo: Data?

}

extension BReview : Identifiable {

}
