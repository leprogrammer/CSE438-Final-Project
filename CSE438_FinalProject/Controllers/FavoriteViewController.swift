//
//  FirstViewController.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/20/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class FavoriteViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //View details of a schedule
        if (segue.identifier == "ViewFavoriteSchedule")
        {
            //TODO: Pass selected course here
            guard segue.destination is ScheduleViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedCourseCell = sender as? ScheduleTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard tableView.indexPath(for: selectedCourseCell) != nil else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            //courseDetailViewController.course = allCourses[indexPath.row]
        }
    }
}

