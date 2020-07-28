//
//  ScheduleViewController.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/21/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit
import QVRWeekView

class ScheduleViewController: UIViewController, WeekViewDelegate {

    var schedule = [Course]()
    var classes = [EventData]()
    var id = 0
    var showSaveButton = false

    @IBOutlet weak var scheduleWeekView: WeekView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scheduleWeekView.zoomOffsetPreservation = .reset
        scheduleWeekView.delegate = self
        scheduleWeekView.eventStyleCallback = { (layer, data) in
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.black.cgColor
            layer.cornerRadius = 5.0
        }
        
        if !schedule.isEmpty {
            convertCourseToEventData()
            scheduleWeekView.showDay(withDate: schedule[0].startDate)
        }
    }
    
    func didLongPressDayView(in weekView: WeekView, atDate date: Date) {
        return
    }

    func didTapEvent(in weekView: WeekView, withId eventId: String) {
        return
    }

    func eventLoadRequest(in weekView: WeekView, between startDate: Date, and endDate: Date) {
        //let datePeriod = DateSupport.getAllDates(between: startDate, and: endDate)


        scheduleWeekView.loadEvents(withData: classes.isEmpty ? nil : classes)
    }
    
    private func convertCourseToEventData() {
        var i = 0
        for course in schedule {
            
            let classDays = [course.sundayClass, course.mondayClass, course.tuesdayClass, course.wednesdayClass, course.thursdayClass, course.fridayClass, course.saturdayClass]
            
            var startComponenets = course.startDate.getDayComponents()
            startComponenets.calendar = Calendar.current
            startComponenets.year = course.startDate.getDayComponents().year
            startComponenets.day = course.startDate.getDayComponents().day
            startComponenets.month = course.startDate.getDayComponents().month
            startComponenets.hour = Int(course.startTime / 100)
            startComponenets.minute = course.startTime % 100
            
            var endComponenets = course.startDate.getDayComponents()
            endComponenets.calendar = Calendar.current
            endComponenets.year = course.startDate.getDayComponents().year
            endComponenets.day = course.startDate.getDayComponents().day
            endComponenets.month = course.startDate.getDayComponents().month
            endComponenets.hour = Int(course.endTime / 100)
            endComponenets.minute = course.endTime % 100
            
            var startDate = startComponenets.date!
            var endDate = endComponenets.date!
            var classCount = 0
            let totalClassCount = numberOfClasses(course: course)
            
            while classCount < totalClassCount {
                if classCount >= 1 {
                    startDate.add(hours: 24)
                    endDate.add(hours: 24)
                }
                
                while !classDays[startDate.getDayOfWeek()] {
                    startDate.add(hours: 24)
                    endDate.add(hours: 24)
                }
                
                let temp = EventData(id: i, title: course.name, startDate: startDate, endDate: endDate, location: course.location ?? "", color: .blue)
                classes.append(temp)
                
                i += 1
                classCount += 1
            }
        }
    }
    
    private func numberOfClasses(course: Course) -> Int {
        var classCount = 0
        
        let classDays = [course.sundayClass, course.mondayClass, course.tuesdayClass, course.wednesdayClass, course.thursdayClass, course.fridayClass, course.saturdayClass]
        for index in 0..<classDays.count {
            if classDays[index] {
                classCount += 1
            }
        }
        
        return classCount
    }
}
