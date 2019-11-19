//
//  Book+CoreDataProperties.swift
//  Bookworm
//
//  Created by CypherPoet on 11/16/19.
// ✌️
//


import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var rating: Int16
    @NSManaged public var author: String?
    @NSManaged public var reviewText: String?
    @NSManaged public var reviewDate: Date?

    @NSManaged private var genreValue: Int16
    
    var genre: Book.Genre {
        get { Book.Genre(rawValue: genreValue)! }
        set { genreValue = newValue.rawValue }
    }
}
