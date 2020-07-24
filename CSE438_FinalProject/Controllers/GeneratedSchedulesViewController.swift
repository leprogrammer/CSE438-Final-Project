//
//  GeneratedSchedulesViewController.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/24/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class GeneratedSchedulesViewController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //View details of a schedule
        if (segue.identifier == "ViewGeneratedSchedule")
        {
            //TODO: Pass selected course here
            guard segue.destination is ScheduleViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedScheduleCell = sender as? ScheduleTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard tableView.indexPath(for: selectedScheduleCell) != nil else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            //courseDetailViewController.course = allCourses[indexPath.row]
        }
    }
}
