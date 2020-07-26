//
//  TableViewCell.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/25/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class DepartmentSelectionViewCell: UITableViewCell {

    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var cell: UIView!
    public static let identifier: String = "DepartmentSelectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setUpCell(departmentStr: String)
    {
        departmentLabel.text = departmentStr
    }

    public func cellSelected(selected: Bool)
    {
        if selected
        {
            departmentLabel.textColor = .white
            cell.backgroundColor = UIColor(hue: 359/360, saturation: 87/100, brightness: 64/100, alpha: 1.0) /* #a51417 */
            departmentLabel.backgroundColor = UIColor(hue: 359/360, saturation: 87/100, brightness: 64/100, alpha: 1.0) /* #a51417 */
        }
        else
        {
            departmentLabel.textColor = .black
            cell.backgroundColor = .white
            departmentLabel.backgroundColor = .white
        }
    }

}
