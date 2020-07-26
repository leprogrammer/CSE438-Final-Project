//
//  UserChoicesViewController.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/25/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class UserChoicesViewController: UIViewController
{
    public static var availableDepartments = ["BIOMEDICAL ENGINEERING-E62", "COMPUTER SCIENCE AND ENGINEERING-E81", "ELECTRICAL AND SYSTEMS ENGINEERING-E35", "GENERAL ENGINEERING-E60", "MECHANICAL ENGINEERING & MATERIALS SCIENCE-E37"]

    private var selectedDepartment = UserChoicesViewController.availableDepartments[0]
    @IBOutlet weak var departmentTableView: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        departmentTableView.delegate = self
        departmentTableView.dataSource = self
    }

    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //View details of a course
        if (segue.identifier == CoursesViewController.segueIdentifier)
        {
            //TODO: Pass selected course here
            guard let courseViewController = segue.destination as? CoursesViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            courseViewController.selectedDepartment = self.selectedDepartment
        }
    }
}

extension UserChoicesViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedDepartment = UserChoicesViewController.availableDepartments[indexPath.row]
        self.departmentTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return UserChoicesViewController.availableDepartments.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = departmentTableView.dequeueReusableCell(withIdentifier: DepartmentSelectionViewCell.identifier) as? DepartmentSelectionViewCell else
        {
            fatalError("Failed to create cell for \(DepartmentSelectionViewCell.identifier)")
        }
        cell.setUpCell(departmentStr: UserChoicesViewController.availableDepartments[indexPath.row])
        cell.cellSelected(selected: UserChoicesViewController.availableDepartments[indexPath.row] == self.selectedDepartment)
        return cell
    }
}
