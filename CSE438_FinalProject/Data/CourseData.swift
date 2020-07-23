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
}

struct Class: Decodable
{
    let set: String?
    let days: [String]
    let startTime: String?
    let endTime: String?
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
