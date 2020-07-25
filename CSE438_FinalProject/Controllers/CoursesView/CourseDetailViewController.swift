//
//  SearchResultsViewController.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/21/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController
{

    @IBOutlet weak var courseTagNameLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var courseDescription: UITextView!
    @IBOutlet weak var classesCollectionView: UICollectionView!
    static let segueIdentifier: String = "ViewCourseDetail"

    var selectedCourseData: CourseData?

    override func viewDidLoad()
    {
        super.viewDidLoad()


        // Setting up the collection view

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 100)
        classesCollectionView.collectionViewLayout = layout
        classesCollectionView.register(ClassCollectionViewCell.nib(), forCellWithReuseIdentifier: ClassCollectionViewCell.identifier)
        classesCollectionView.dataSource = self

        guard let courseData: CourseData = selectedCourseData else
        {
            fatalError("Could not obtain courseData from selected course.")
        }
        setUpView(courseData: courseData)
    }

    func setUpView(courseData: CourseData)
    {
        courseTagNameLabel.text = courseData.courseTag + " : " + courseData.courseName
        unitsLabel.text = "Units: " + courseData.units
        courseDescription.text = "Description: " + (courseData.description ?? "No Description Provided")
        
    }


}

extension CourseDetailViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // Need to specify actual items
        return self.selectedCourseData?.classes.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassCollectionViewCell.identifier, for: indexPath) as? ClassCollectionViewCell
        else{
            fatalError("Failed to create cell for \(ClassCollectionViewCell.identifier)")
        }

        // If I can get the department then I know there's courses in them
        if let c: Class = self.selectedCourseData?.classes[indexPath.row]
        {
            cell.configure(class: c)
        }

        cell.contentView.layer.cornerRadius = 2.0;
        cell.contentView.layer.borderWidth = 1.0;
        cell.contentView.layer.borderColor = UIColor.clear.cgColor;
        cell.contentView.layer.masksToBounds = true;

        cell.layer.shadowColor = UIColor.black.cgColor;
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0);
        cell.layer.shadowRadius = 2.0;
        cell.layer.shadowOpacity = 0.5;
        cell.layer.masksToBounds = false;

        /*cell.layer.shadowPath = [UIBezierPath, bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath*/

        return cell
    }

}

