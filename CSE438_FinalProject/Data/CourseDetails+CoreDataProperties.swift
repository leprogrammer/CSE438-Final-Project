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

    static func == (lhs: CourseDetails, rhs: CourseDetails) -> Bool
    {
        return lhs.endDate == rhs.endDate && lhs.endTime == rhs.endTime && lhs.startDate == rhs.startDate
            && lhs.startTime == rhs.startTime && lhs.location == rhs.location && lhs.prof == rhs.prof
            && lhs.name == rhs.name && lhs.section == rhs.section
            && lhs.sundayClass == rhs.sundayClass && lhs.mondayClass == rhs.mondayClass && lhs.tuesdayClass == rhs.tuesdayClass
            && lhs.wednesdayClass == rhs.wednesdayClass && lhs.thursdayClass == rhs.thursdayClass && lhs.fridayClass == rhs.fridayClass
            && lhs.saturdayClass == rhs.saturdayClass
    }
    
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
