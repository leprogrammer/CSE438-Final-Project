//
//  CourseDetails+CoreDataProperties.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/29/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//
//

import Foundation
import CoreData


extension CourseDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseDetails> {
        return NSFetchRequest<CourseDetails>(entityName: "CourseDetails")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var endTime: Int32
    @NSManaged public var fridayClass: Bool
    @NSManaged public var location: String?
    @NSManaged public var mondayClass: Bool
    @NSManaged public var name: String?
    @NSManaged public var prof: String?
    @NSManaged public var saturdayClass: Bool
    @NSManaged public var section: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var startTime: Int32
    @NSManaged public var sundayClass: Bool
    @NSManaged public var thursdayClass: Bool
    @NSManaged public var tuesdayClass: Bool
    @NSManaged public var wednesdayClass: Bool
    @NSManaged public var relationship: ClassSchedule?

}
