//
//  Course+CoreDataProperties.swift
//  
//
//  Created by Tejas Prasad on 7/29/20.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var name: String?
    @NSManaged public var section: String?
    @NSManaged public var prof: String?
    @NSManaged public var location: String?
    @NSManaged public var startTime: Int32
    @NSManaged public var endTime: Int32
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var mondayClass: Bool
    @NSManaged public var tuesdayClass: Bool
    @NSManaged public var wednesdayClass: Bool
    @NSManaged public var thursdayClass: Bool
    @NSManaged public var fridayClass: Bool
    @NSManaged public var saturdayClass: Bool
    @NSManaged public var sundayClass: Bool
    @NSManaged public var relationship: Schedule?

}
