//
//  CoursesCollectionViewCell.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/24/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class CoursesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var addOrRemoveCourseBtn: UIButton!
    @IBOutlet weak var unitsLabel: UILabel!

    static let identifier: String = "CoursesCollectionViewCell"
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }


    public func configure(course: CourseData)
    {
        courseNameLabel.text = course.courseTag + " : " + course.courseName
        unitsLabel.text = course.units
    }

    static func nib() -> UINib
    {
        return UINib(nibName: "CoursesCollectionViewCell", bundle: nil)
    }

}
