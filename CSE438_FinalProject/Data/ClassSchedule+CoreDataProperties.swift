//
//  ClassSchedule+CoreDataProperties.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/29/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//
//

import Foundation
import CoreData


extension ClassSchedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassSchedule> {
        return NSFetchRequest<ClassSchedule>(entityName: "ClassSchedule")
    }

    @NSManaged public var courses: NSSet?

}

// MARK: Generated accessors for courses
extension ClassSchedule {

    @objc(addCoursesObject:)
    @NSManaged public func addToCourses(_ value: CourseDetails)

    @objc(removeCoursesObject:)
    @NSManaged public func removeFromCourses(_ value: CourseDetails)

    @objc(addCourses:)
    @NSManaged public func addToCourses(_ values: NSSet)

    @objc(removeCourses:)
    @NSManaged public func removeFromCourses(_ values: NSSet)

}
