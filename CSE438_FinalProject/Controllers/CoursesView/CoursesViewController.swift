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
    @IBOutlet weak var generateScheduleBtn: UIButton!

    public static let segueIdentifier: String = "CoursesViewController"

    let activityIndicator = UIActivityIndicatorView(style: .large)

    var loadedDepartment: Department?
    var selectedDepartment: String?
    var selectedCourses: [Int: CourseData] = [:]
    var numberOfCourses = 0

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
        enableDisableGenerateScheduleButton()
    }

    func getDepartment()
    {
        guard let department: String = self.selectedDepartment else
        {
            fatalError("Failed to get selected department.")
        }
        showActivity()
        GetData.getCourses(department: department, completion: { apiResults in
            switch apiResults {
            case .error(let error) :
                print("Error Searching: \(error)")
                return
            case .results(let results):
                self.loadedDepartment = results
                self.coursesCollectionView.reloadData()
                self.coursesCollectionView.layoutIfNeeded()
            }
            self.stopActivity()
        })
    }

    func showActivity()
    {
        coursesCollectionView.addSubview(self.activityIndicator)
        activityIndicator.frame = coursesCollectionView.bounds
        activityIndicator.startAnimating()
    }

    func stopActivity()
    {
        self.activityIndicator.stopAnimating()
    }

    // If there are not selected button then the button is disabled
    func enableDisableGenerateScheduleButton()
    {
        generateScheduleBtn.isEnabled = selectedCourses.count != 0
        (selectedCourses.count != 0) ? (generateScheduleBtn.backgroundColor = UIColor.blue) : (generateScheduleBtn.backgroundColor = UIColor.black)
    }

    func generateCourses() -> [Course]
    {
        var courses: [Course] = []
        for courseData in selectedCourses.values
        {
            for class_ in courseData.classes
            {
                if let startTime: String = class_.startTime, let endTime: String = class_.endTime
                {
                    let start24Time = CourseData.convert12To24(timeStr: startTime)
                    let end24Time = CourseData.convert12To24(timeStr: endTime)

                    if (start24Time != nil && end24Time != nil)
                    {
                        // I know the strings aren't nil since i'm checking
                        guard let startTimeInt = CourseData.convert24HourStringToInt(timeStr: start24Time!) else
                        {
                            fatalError("Failed to convert start24Time: \(start24Time ?? "nil") to int.")
                        }
                        guard let endTimeInt = CourseData.convert24HourStringToInt(timeStr: end24Time!) else
                        {
                            fatalError("Failed to convert end24Time: \(end24Time ?? "nil") to int.")
                        }

                        if (class_.days.count > 0 )
                        {
                            let classDays = CourseData.convertDaysOfWeekToBool(days: class_.days)

                            let startDate = CourseData.getDate(date: class_.startDate)
                            let endDate = CourseData.getDate(date: class_.endDate)

                            courses.append(Course(name: courseData.courseName, section: class_.sec, prof: class_.instructor ?? "", startTime: startTimeInt, endTime: endTimeInt, startDate: startDate, endDate: endDate, mondayClass: classDays[0], tuesdayClass: classDays[1], wednesdayClass: classDays[2], thursdayClass: classDays[3], fridayClass: classDays[4], saturdayClass: classDays[5], sundayClass: classDays[6]))
                        }

                    }
                    else
                    {
                        fatalError("StartTime: \(startTime) EndTime: \(endTime) Producing nil when converted to 24 hours time.")
                    }
                }

            }
        }
        return courses
    }

    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //View details of a course
        if (segue.identifier == CourseDetailViewController.segueIdentifier)
        {
            //TODO: Pass selected course here
            guard let courseDetailViewController = segue.destination as? CourseDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCourseCell = sender as? CoursesCollectionViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = coursesCollectionView.indexPath(for: selectedCourseCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            courseDetailViewController.selectedCourseData = loadedDepartment?.courses[indexPath.item]
        }
        else if (segue.identifier == "GenerateSchedules")
        {
            guard let generatedSchedulesViewController = segue.destination as? GeneratedSchedulesViewController else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            // settings the generated courses
            generatedSchedulesViewController.selectedClasses = generateCourses()
            generatedSchedulesViewController.numberOfCourses = numberOfCourses
        }
    }

}

//MARK: Extensions
extension CoursesViewController: CoursesCollectionViewCellDelegate
{
    func addCourse(index: Int)
    {
        guard let department : Department = self.loadedDepartment else
        {
            fatalError("Failed to obtain department to add course")
        }

        selectedCourses.updateValue(department.courses[index], forKey: index)
        numberOfCourses += 1
        enableDisableGenerateScheduleButton()
    }

    func removeCourse(index: Int)
    {
        selectedCourses.removeValue(forKey: index)
        numberOfCourses -= 1
        if numberOfCourses <= 0 {
            numberOfCourses = 0
        }
        enableDisableGenerateScheduleButton()
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
        return self.loadedDepartment?.courses.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoursesCollectionViewCell.identifier, for: indexPath) as? CoursesCollectionViewCell else
        {
            fatalError("Failed to create cell for \(CoursesCollectionViewCell.identifier)")
        }

        // If I can get the department then I know there's courses in them
        if let department : Department = self.loadedDepartment
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


