//
//  PersistenceHelper.swift
//  Lab4
//
//  Created by Harprabh Sangha on 7/16/20.
//  Copyright © 2020 Harprabh Sangha. All rights reserved.
//

//
//  PersistenceHelper.swift
//  Virtual Pet
//
//  Created by Harprabh Sangha on 6/25/20.
//  Copyright © 2020 Harprabh Sangha. All rights reserved.
//

import Foundation
import CoreData
import os.log


/**
 Creating a static object seemed like the cleanest way to maintain all the auto generated code
 */
class PersistenceHelper
{

    private init(){}

    // MARK: - Core Data stack
    static var context: NSManagedObjectContext{
        return persistentContainer.viewContext
    }

    static public func saveSchedule(schedule: [Course])
    {
        if !isScheduleAlreadySaved(schedule: schedule) {
            let savedSchedule = convertCourseToSchedule(courseArray: schedule)
            
            PersistenceHelper.saveContext()
        }
    }

    /**
     Making this public static... so I can keep the mess here
     */
    static public func getSavedSchedules() -> [[Course]]
    {
        var schedules = [ClassSchedule]()
        let fetchRequest: NSFetchRequest<ClassSchedule> = ClassSchedule.fetchRequest()
        do {
            let savedSchedules = try PersistenceHelper.context.fetch(fetchRequest)

//            for favMovie in FavMovieItems
//            {
//                favMovies.append(savedSchedule)
//            }

        }
        catch
        {
            os_log("Failed to obtain Favorite Movie items", type: .error)
        }

        return [[Course]]() //favMovies
    }

    static public func removeSavedSchedule(schedule: [Course])
    {
        let fetchRequest: NSFetchRequest<ClassSchedule> = ClassSchedule.fetchRequest()
        do {
            let savedSchedules = try  PersistenceHelper.context.fetch(fetchRequest)

            for item in savedSchedules
            {
//                if let title : String = favMovie.title
//                {
//                    if title == movieTitle
//                    {
//                        PersistenceHelper.context.delete(favMovie)
//                        break
//                    }
//                }
            }
            PersistenceHelper.saveContext()

        }
        catch
        {
            os_log("Failed to Delete Favorite Movie", type: .error)
        }
    }

    static public func isScheduleAlreadySaved(schedule: [Course]) -> Bool
    {
        if schedule.isEmpty
        {
            return false
        }

        for savedSchedule in PersistenceHelper.getSavedSchedules()
        {
//            if let title : String = favMovie.title
//            {
//                if title == movieTitle
//                {
//                    return true
//                }
//            }
        }
        return false
    }


    static public var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    static func saveContext () {
        let context = PersistenceHelper.context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                os_log("Failed to saveContext data for PetStore", type: .error)
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func convertCourseToSchedule(courseArray: [Course]) -> ClassSchedule {
        
        let schedule = ClassSchedule(context: PersistenceHelper.context)
        
        for item in courseArray {
            let temp = CourseDetails()
            temp.name = item.name
            temp.section = item.section
            temp.prof = item.prof
            temp.location = item.location
            temp.startTime = Int32(item.startTime)
            temp.endTime = Int32(item.endTime)
            temp.startDate = item.startDate
            temp.endDate = item.endDate
            temp.mondayClass = item.mondayClass
            temp.tuesdayClass = item.tuesdayClass
            temp.wednesdayClass = item.wednesdayClass
            temp.thursdayClass = item.thursdayClass
            temp.fridayClass = item.fridayClass
            temp.saturdayClass = item.saturdayClass
            temp.sundayClass = item.sundayClass
            
            schedule.addToCourses(temp)
        }
        
        return schedule
    }
}
