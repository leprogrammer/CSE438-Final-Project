//
//  CoursesTableViewCell.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/23/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell
{
    
    static let identifier: String = "CoursesTableViewCell"
    
    @IBOutlet weak var courseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell(courseName: String)
    {
        courseNameLabel.text = courseName
    }
    
}
