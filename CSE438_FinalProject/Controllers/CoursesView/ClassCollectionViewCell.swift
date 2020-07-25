//
//  ClassCollectionViewCell.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/24/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class ClassCollectionViewCell: UICollectionViewCell
{

    static let identifier: String = "ClassCollectionViewCell"

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib
    {
        return UINib(nibName: ClassCollectionViewCell.identifier, bundle: nil)
    }

    func configure(class: Class)
    {
        
    }



}
