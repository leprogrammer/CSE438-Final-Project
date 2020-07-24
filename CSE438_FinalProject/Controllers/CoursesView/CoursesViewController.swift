//
//  SecondViewController.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/20/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit


class CoursesViewController: UIViewController
{

    @IBOutlet weak var coursesCollectionView: UICollectionView!
    var selectedDepartment: Department?
    var selectedCourses: [Int: CourseData] = [:]

    static let removeCourseButtonLabel : String = "Remove Favorite"
    static let addCourseButtonLabel : String = "Add Favorite"

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Setting up the collection view

        let layout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width: 350, height: 100)
         coursesCollectionView.collectionViewLayout = layout
        coursesCollectionView.register(CoursesCollectionViewCell.nib(), forCellWithReuseIdentifier: CoursesCollectionViewCell.identifier)
        coursesCollectionView.delegate = self
        coursesCollectionView.dataSource = self

        getDepartment()
    }

    func getDepartment()
    {
        GetData.getCourses(){ apiResults in
            switch apiResults {
            case .error(let error) :
                print("Error Searching: \(error)")
                return
            case .results(let results):
                self.selectedDepartment = results
                self.coursesCollectionView.reloadData()
                self.coursesCollectionView.layoutIfNeeded()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //View details of a course
        if (segue.identifier == CourseDetailViewController.segueIdentifier)
        {
            //TODO: Pass selected course here
            guard segue.destination is CourseDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCourseCell = sender as? CoursesCollectionViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard coursesCollectionView.indexPath(for: selectedCourseCell) != nil else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            //courseDetailViewController.course = allCourses[indexPath.row]
        }
    }

}

extension CoursesViewController: CoursesCollectionViewCellDelegate
{
    func addCourse(index: Int)
    {
        guard let department : Department = self.selectedDepartment else
        {
            fatalError("Failed to obtain department to add course")
        }

        selectedCourses.updateValue(department.courses[index], forKey: index)
    }

    func removeCourse(index: Int)
    {

        selectedCourses.removeValue(forKey: index)
    }


}

/**
 Helps pick up interaction with the cells
 */
extension CoursesViewController: UICollectionViewDelegate
{
    /**
     Gets called when user taps on one of the collection view
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // perform Segue
        collectionView.deselectItem(at: indexPath, animated: true)
        self.performSegue(withIdentifier: CourseDetailViewController.segueIdentifier, sender: collectionView.cellForItem(at: indexPath))
    }
}

extension CoursesViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // Need to specify actual items
        return self.selectedDepartment?.courses.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoursesCollectionViewCell.identifier, for: indexPath) as! CoursesCollectionViewCell

        // If I can get the department then I know there's courses in them
        if let department : Department = self.selectedDepartment
        {
            cell.configure(course: department.courses[indexPath.row], index: indexPath.row)
            cell.setAddOrRemoveBtn(courseSelected: self.selectedCourses.keys.contains(indexPath.row))
        }

        cell.delegate = self

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

/**
 Helps customize
 */
extension CoursesViewController: UICollectionViewDelegateFlowLayout
{
    // Here if we want to do any customization
}


