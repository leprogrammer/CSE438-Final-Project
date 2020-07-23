//
//  SecondViewController.swift
//  CSE438_FinalProject
//
//  Created by Tejas Prasad on 7/20/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit


var selectedDepartment: Department?

class SearchViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
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
                selectedDepartment = results
            }
        }
    }

}

