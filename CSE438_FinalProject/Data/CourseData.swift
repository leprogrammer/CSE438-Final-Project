//
//  CourseData.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/22/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import Foundation

public let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
public let finalExamType = ["No final", "No Final", "Default - none", "Paper/Project/TakeHome"]

struct Department: Decodable
{
    let department: String!
    let courses: [CourseData]
}

struct CourseData: Decodable
{
    let courseName: String!
    let courseTag: String!
    let units: String!
    let description: String?
    let classes: [Class]

    /// Converts 1:24 PM to 13:24 https://stackoverflow.com/questions/29321947/xcode-swift-am-pm-time-to-24-hour-format
    public static func convert12To24(timeStr: String) -> String?
    {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        dateFormatter.dateFormat = "h:mm a"

        var date = dateFormatter.date(from: timeStr)

        if date == nil
        {
            dateFormatter.dateFormat = "h:mma"
            date = dateFormatter.date(from: timeStr)
        }

        if date == nil { return nil}

        dateFormatter.dateFormat = "HH:mm"

        // returning nil above if date is nil
        let time24 = dateFormatter.string(from: date!)
        return time24
    }

    public static func convert24HourStringToInt(timeStr: String)-> Int?
    {
        let parsed = timeStr.replacingOccurrences(of: ":", with: "")
        return Int(parsed) ?? nil
    }

    public static func convertDaysOfWeekToBool(days: [String])-> [Bool]
    {
        var boolOfWeeks = [false, false, false, false, false, false, false]
        for day in days
        {
            if let loc: Int = daysOfWeek.firstIndex(of: day)
            {
                boolOfWeeks[loc] = true
            }
        }

        return boolOfWeeks
    }

    public static func getDate(date: String) -> Date
    {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "m/dd/yyyy"
        guard let returnDate = inputFormatter.date(from: date) else
        {
            fatalError("Failed to get dateObject from \(date)")
        }
        return returnDate
    }
}

struct Class: Decodable
{
    let sec: String!
    let days: [String]
    let startTime: String?
    let endTime: String?
    let startDate: String!
    let endDate: String!
    let location: String?
    let locationRef: String?
    let instructor: String?
    let instructorLink: String?
    let finalExam: FinalExam!
}

struct FinalExam: Decodable
{
    let type: String
    let finalExamDay: String?
    let finalExamStartTime: String?
    let finalExamEndTime: String?
}
