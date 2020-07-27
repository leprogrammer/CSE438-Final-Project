//
//  FilterCollectionViewCell.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/26/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {

    static let identifier: String = "FilterCollectionViewCell"

    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var restrictionTypeTextBox: UITextField!
    @IBOutlet weak var startTimeTextBox: UITextField!
    @IBOutlet weak var endTimeTextBox: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var helperLabel: UILabel!
    var restriction: Restriction?

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.type.delegate = self

        createRestrictionTypePicker()
    }

    // Makes sure you can't delete the text field items
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }

    static func nib() -> UINib
    {
        return UINib(nibName: FilterCollectionViewCell.identifier, bundle: nil)
    }

    func createRestrictionTypePicker()
    {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 200.0))
        picker.delegate = self

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        toolBar.setItems([doneBtn], animated: true)
        type.inputView = picker
        type.inputAccessoryView = toolBar
    }

    @objc func doneClicked()
    {
        self.endEditing(true)
    }

    func configure(obj: Restriction)
    {
        restriction = obj
        dayOfWeekLabel.text = obj.dayOfWeek
        type.text = restrictionType[obj.type]
        filterDecision(decision: obj.type)
    }

    func filterDecision(decision: Int)
    {
        if decision == 0
        {
            startTimeTextBox.isHidden = true
            helperLabel.isHidden = true
            endTimeTextBox.isHidden = true
            
        }
        else if decision == 1
        {
            startTimeTextBox.isHidden = true
            helperLabel.isHidden = true
            endTimeTextBox.isHidden = true
        }
        else if decision == 2
        {
            startTimeTextBox.isHidden = false
            startTimeTextBox.placeholder = "Select Time"
            helperLabel.isHidden = true
            endTimeTextBox.isHidden = true
        }
        else if decision == 3
        {
            startTimeTextBox.isHidden = false
            startTimeTextBox.placeholder = "Select Time"
            helperLabel.isHidden = true
            endTimeTextBox.isHidden = true
        }
        else if decision == 4
        {
            startTimeTextBox.isHidden = false
            startTimeTextBox.placeholder = "Select Time"
            helperLabel.isHidden = false
            helperLabel.text = " and "
            endTimeTextBox.isHidden = false
            endTimeTextBox.placeholder = "Select Time"
        }
        else
        {
            fatalError("Incorrect decision passed \(decision)")
        }
    }

}

extension FilterCollectionViewCell: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return restrictionType.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return restrictionType[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.restriction?.type = row
        type.text = restrictionType[row]
        self.filterDecision(decision: row)
    }
}
