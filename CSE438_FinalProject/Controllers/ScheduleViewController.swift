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
    
    var classes = [EventData]()
    var id = 0
    
    @IBOutlet var scheduleWeekView: WeekView!
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
}

