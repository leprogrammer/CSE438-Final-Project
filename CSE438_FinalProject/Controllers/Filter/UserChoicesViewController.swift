//
//  UserChoicesViewController.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/25/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

struct Restriction {
    let dayOfWeek: String
    var type: Int = 0
    var startTime: String = ""
    var endTime: String = ""
}

let restrictionType = ["No Restriction", "No Class All Day", "No Class Before", "No Class After", "No Class Between", "Only Classes Between"]

class UserChoicesViewController: UIViewController
{
    public static var availableDepartments = ["BIOMEDICAL ENGINEERING-E62", "COMPUTER SCIENCE AND ENGINEERING-E81", "ELECTRICAL AND SYSTEMS ENGINEERING-E35", "GENERAL ENGINEERING-E60", "MECHANICAL ENGINEERING & MATERIALS SCIENCE-E37"]

    private var selectedDepartment = UserChoicesViewController.availableDepartments[0]
    @IBOutlet weak var departmentTableView: UITableView!
    @IBOutlet weak var filterOutSelfStudySwitch: UISwitch!
    @IBOutlet weak var userChoiceCollectionView: UICollectionView!
    
    let datePicker = UIDatePicker()
    var restrictions :[Restriction] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()

        departmentTableView.delegate = self
        departmentTableView.dataSource = self

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 100)
        userChoiceCollectionView.collectionViewLayout = layout
        userChoiceCollectionView.register(FilterCollectionViewCell.nib(), forCellWithReuseIdentifier: FilterCollectionViewCell.identifier)
        userChoiceCollectionView.delegate = self
        userChoiceCollectionView.dataSource = self

        createRestrictions()
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
            courseViewController.filterOutSelfStudy = self.filterOutSelfStudySwitch.isOn
        }
    }

    func createRestrictions()
    {
        for day in daysOfWeek
        {
            if day == "Saturday" || day == "Sunday"
            {
                restrictions.append(Restriction(dayOfWeek: day, type: 1))
            }
            else
            {
                restrictions.append(Restriction(dayOfWeek: day))
            }

        }
    }

}

extension UserChoicesViewController: FilterCollectionViewCellDelegate
{
    func restrictionUpdated(restriction: Restriction, index: Int) {
        self.restrictions[index].type = restriction.type
        self.restrictions[index].startTime = restriction.startTime
        self.restrictions[index].endTime = restriction.endTime
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

extension UserChoicesViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        // Need to specify actual items
        return restrictions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.identifier, for: indexPath) as? FilterCollectionViewCell else
        {
            fatalError("Failed to create cell for \(FilterCollectionViewCell.identifier)")
        }

        cell.configure(obj: restrictions[indexPath.row], index: indexPath.row)
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
