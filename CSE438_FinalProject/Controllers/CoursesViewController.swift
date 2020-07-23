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
    @IBOutlet weak var coursesTableView: UITableView!
    var selectedDepartment: Department?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        coursesTableView.delegate = self
        coursesTableView.dataSource = self

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
                self.coursesTableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == CourseDetailViewController.segueIdentifier)
        {
            //TODO: Pass selected course here
            guard let courseDetailViewController = segue.destination as? CourseDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCourseCell = sender as? CoursesTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = coursesTableView.indexPath(for: selectedCourseCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            //courseDetailViewController.course = allCourses[indexPath.row]
        }
    }

}

extension CoursesViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.selectedDepartment?.courses.count ?? 0;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: CoursesTableViewCell.identifier) as! CoursesTableViewCell
        if let department = self.selectedDepartment
        {
            if department.courses.count > 0
            {
                cell.setupCell(courseName: department.courses[indexPath.row].courseName)
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        // TODO : Add slid to add course and if course is added slide to delete
        /*if editingStyle == .delete
        {
        }*/
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)

        // Get the row selected

        //self.performSegue(withIdentifier: CourseDetailViewController.segueIdentifier, sender: nil)
    }


}


