//
//  FirstViewController.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/20/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UITableViewController {

    let identifier = "FavoriteScheduleCell"
    static var schedules: [NSManagedObject] = []
    static var favoriteSchedules = [String: [Course]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        if let userFavorites = defaults.object(forKey: "UserFavoritesDict") as? [String: [Course]] {
            FavoriteViewController.favoriteSchedules = userFavorites
        }
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoriteViewController.favoriteSchedules.removeValue(forKey: Array(FavoriteViewController.favoriteSchedules.keys)[indexPath.item])
            let defaults = UserDefaults.standard
            defaults.set(FavoriteViewController.favoriteSchedules, forKey: "UserFavoritesDict")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ScheduleTableViewCell
        
        cell.scheduleTitle.text = "Schedule #" + String(indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteViewController.favoriteSchedules.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //View details of a schedule
        if (segue.identifier == "ViewFavoriteSchedule")
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
            
            scheduleViewController.schedule = FavoriteViewController.favoriteSchedules[Array(FavoriteViewController.favoriteSchedules.keys)[indexPath.item]]!
            scheduleViewController.showSaveButton = true
        }
    }
}

