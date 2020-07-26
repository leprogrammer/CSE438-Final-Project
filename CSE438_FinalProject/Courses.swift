//
//  Courses.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/21/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import Foundation

struct Course {
    let name: String
    let section: String?
    let prof: String
    let startTime: Int //convert to 24 hour time
    let endTime: Int //convert to 24 hour time
    let startDate: Date
    let endDate: Date
    let mondayClass: Bool
    let tuesdayClass: Bool
    let wednesdayClass: Bool
    let thursdayClass: Bool
    let fridayClass: Bool
    let saturdayClass: Bool
    let sundayClass: Bool
}

struct Restriction {
    let startTime: Int // 24 hour time
    let endTime: Int // 24 hour time
    let mondayClass: Bool
    let tuesdayClass: Bool
    let wednesdayClass: Bool
    let thursdayClass: Bool
    let fridayClass: Bool
    let saturdayClass: Bool
    let sundayClass: Bool
}

let allCourses = [Course]()

//Pass in array of classes the student collected. If they didn't select a specific section, add all sections of that class. Also pass in the number of classes they selected (number of unique course names)
func generateSchedules(selectedCourses: [Course], numberOfCoursesSelected: Int) -> [[Course]] {
    let temp = selectedCourses.powerSet//permutations(xs: selectedCourses) as [[Course]]
    
    return temp.filter { checkScheduleValid(schedule: $0) && $0.count <= numberOfCoursesSelected && $0.count > 0}
}

//Check if array of classes is a valid schedule (no time conflicts and no duplicates)
func checkScheduleValid(schedule: [Course]) -> Bool {
    var i = 0
    for item in schedule { 
        i += 1
        if i >= schedule.count {
            break
        }
        else {
            for index in i..<schedule.count {
                if item.name == schedule[index].name {// check if schedule has same class but different sections in it
                    return false
                }
                if doesClassConflict(a: item, b: schedule[index]) {
                    return false
                }
            }
        }
    }
    //Schedule has no time conflicts
    return true
}

//Helper function to check if there is a time conflict between two classes
func doesClassConflict(a: Course, b: Course) -> Bool {
    if (a.mondayClass && b.mondayClass)
        || (a.tuesdayClass && b.tuesdayClass)
        || (a.wednesdayClass && b.wednesdayClass)
        || (a.thursdayClass && b.thursdayClass)
        || (a.fridayClass && b.fridayClass)
        || (a.saturdayClass && b.saturdayClass)
        || (a.sundayClass && b.sundayClass)
        // Check if classes are on same day
    {
        if (a.endTime <= b.startTime)
            || (b.endTime <= a.startTime) //covers case where class times don't conflict
            
        {
            return false
        }
        else
        {
            return true //Class times do conflict
        }
    }
    else
    {
        return false //classes are not on same day
    }
}
