//
//  GeneratedSchedulesViewController.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/24/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class GeneratedSchedulesViewController : UITableViewController {
    
    let identifier = "GenerateScheduleCell"
    var selectedClasses = [Course]()
    var numberOfCourses = 0
    var generatedSchedules = [[Course]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let activity = UIActivityIndicatorView(style: .medium)
        tableView.addSubview(activity)
        activity.frame = tableView.bounds
        activity.startAnimating()
        DispatchQueue.global().async {
            self.generatedSchedules = generateSchedules(selectedCourses: self.selectedClasses, numberOfCoursesSelected: self.numberOfCourses)
            
            DispatchQueue.main.async {
                activity.stopAnimating()
                activity.removeFromSuperview()
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScheduleTableViewCell
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generatedSchedules.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //View details of a schedule
        if (segue.identifier == "ViewGeneratedSchedule")
        {
            //TODO: Pass selected course here
            guard let scheduleViewController = segue.destination as? ScheduleViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedScheduleCell = sender as? ScheduleTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedScheduleCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            scheduleViewController.schedule = generatedSchedules[indexPath.row]
            scheduleViewController.showSaveButton = true
        }
    }
}
