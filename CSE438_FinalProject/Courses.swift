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
    let section: Int?
    let prof: String
    let startTime: Int //convert to 24 hour time
    let endTime: Int //convert to 24 hour time
    let mondayClass: Bool
    let tuesdayClass: Bool
    let wednesdayClass: Bool
    let thursdayClass: Bool
    let fridayClass: Bool
}

let allCourses = [Course]()
let selectedCourses = [Course]()


func generateSchedules() {
    let temp = permutations(xs: selectedCourses) as [[Course]]
    for schedule in temp {
        _ = checkScheduleValid(schedule: schedule)
    }
}

func checkScheduleValid(schedule: [Course]) -> Bool {
    var i = 0
    for item in schedule { 
        i += 1
        if i >= schedule.count {
            break
        }
        else {
            for index in i..<schedule.count {
                if doesClassConflict(a: item, b: schedule[index]) {
                    return false
                }
            }
        }
    }
    return true
}

func doesClassConflict(a: Course, b: Course) -> Bool {
    if (a.mondayClass && b.mondayClass)
        || (a.tuesdayClass && b.tuesdayClass)
        || (a.wednesdayClass && b.wednesdayClass)
        || (a.thursdayClass && b.thursdayClass)
        || (a.fridayClass && b.fridayClass)
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
