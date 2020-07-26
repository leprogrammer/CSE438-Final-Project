//
//  ClassCollectionViewCell.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/24/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class ClassCollectionViewCell: UICollectionViewCell
{


    static let identifier: String = "ClassCollectionViewCell"
    var cellClass: Class?

    @IBOutlet weak var daysOfWeekLabel: UILabel!
    @IBOutlet weak var secLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var finalExamLabel: UILabel!


    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib
    {
        return UINib(nibName: ClassCollectionViewCell.identifier, bundle: nil)
    }

    func configure(c: Class)
    {
        cellClass = c
        secLabel.text = "Sec: " + c.sec
        if c.days.count == 0
        {
            daysOfWeekLabel.text = "Days: TBA"
        }
        else
        {
            var days = ""
            for day:String in c.days
            {
                days += day + " "

            }
            daysOfWeekLabel.text = days
        }

        var time = "ClassTime: "
        if let startTime: String = c.startTime
        {
            if let endTime: String = c.endTime
            {
                if !startTime.isEmpty && !endTime.isEmpty
                {
                    time += startTime + " - "  + endTime
                }
                else
                {
                    time += "No time set"
                }
            }
        }
        timeLabel.text = time

        dateLabel.text = "Start: " + c.startDate + " End: " + c.endDate

        
        locationButton.setTitle((c.location ?? ""), for: .normal)
        locationButton.isUserInteractionEnabled = false
        if let locationLink = c.locationRef
        {
            if !locationLink.isEmpty
            {
                locationButton.isUserInteractionEnabled = true
                locationButton.setTitleColor(.blue, for: .normal)
            }
        }

        instructorLabel.text = "Instructor: " + (c.instructor ?? "")

        if c.finalExam.type == "In Class"
        {
            var time = "Final: " + (c.finalExam.finalExamDay ?? "No day set.")
            time += " " + (c.finalExam.finalExamStartTime ?? " No time set.")
            if let endTime: String = c.finalExam.finalExamEndTime
            {
                 time += " - "  + endTime
            }
            finalExamLabel.text =  time
        }
        else
        {
            finalExamLabel.text = c.finalExam.type
        }

    }


    @IBAction func locationClicked(_ sender: Any)
    {
        guard let c = self.cellClass else
        {
            fatalError("Cell class is nil")
        }

        if let locationLink = c.locationRef
        {
            if !locationLink.isEmpty
            {
                if let url = URL(string: locationLink) {
                    UIApplication.shared.open(url)
                }
            }
        }

    }
}
