//
//  FilterCollectionViewCell.swift
//  CSE438_FinalProject
//
//  Created by Harprabh Sangha on 7/26/20.
//  Copyright © 2020 Tejas Prasad. All rights reserved.
//

import UIKit

protocol FilterCollectionViewCellDelegate {
    func restrictionUpdated(restriction: Restriction, index: Int)
}

class FilterCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {

    static let identifier: String = "FilterCollectionViewCell"

    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var restrictionTypeTextBox: UITextField!
    @IBOutlet weak var startTimeTextBox: UITextField!
    @IBOutlet weak var endTimeTextBox: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var helperLabel: UILabel!

    var restriction: Restriction?
    var index: Int = 0
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    var delegate: FilterCollectionViewCellDelegate?

    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.type.delegate = self
        self.startTimeTextBox.delegate = self
        self.endTimeTextBox.delegate = self

        createRestrictionTypePicker()
        setUpDatePickers()
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

    func setUpDatePickers()
    {
        startDatePicker = UIDatePicker()
        endDatePicker = UIDatePicker()

        startDatePicker?.datePickerMode = .time
        startDatePicker?.addTarget(self, action: #selector(startDateChanged(datePicker: )), for: .valueChanged)
        endDatePicker?.datePickerMode = .time
        endDatePicker?.addTarget(self, action: #selector(endDateChanged(datePicker: )), for: .valueChanged)

        startTimeTextBox.inputView = startDatePicker
        endTimeTextBox.inputView = endDatePicker

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(startDone))
        toolBar.setItems([doneBtn], animated: true)

        let toolBar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        let doneBtn2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endDone))
        toolBar2.setItems([doneBtn2], animated: true)

        startTimeTextBox.inputAccessoryView = toolBar
        endTimeTextBox.inputAccessoryView = toolBar2
    }

    @objc func startDateChanged(datePicker: UIDatePicker)
    {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a"
        startTimeTextBox.text = dateFormater.string(from: datePicker.date)
        changeDataModelBasedOnDecision(decision: self.restriction?.type ?? 0)
    }

    @objc func endDateChanged(datePicker: UIDatePicker)
    {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "h:mm a"
        endTimeTextBox.text = dateFormater.string(from: datePicker.date)
        changeDataModelBasedOnDecision(decision: self.restriction?.type ?? 2)
    }

    @objc func startDone()
    {
        self.endEditing(true)
        if let picker: UIDatePicker = startDatePicker
        {
            startDateChanged(datePicker: picker)
        }
    }

    @objc func endDone()
    {
        self.endEditing(true)
        if let picker: UIDatePicker = endDatePicker
        {
            endDateChanged(datePicker: picker)
        }

    }

    func configure(obj: Restriction, index: Int)
    {
        restriction = obj
        self.index = index
        dayOfWeekLabel.text = obj.dayOfWeek
        type.text = restrictionType[obj.type]
        changeUiToMatchDecision(decision: obj.type)
    }

    func changeDataModelBasedOnDecision(decision: Int)
    {
        if decision == 0 || decision == 1
        {
            self.restriction?.startTime = ""
            self.restriction?.endTime = ""
            startTimeTextBox.text?.removeAll()
            endTimeTextBox.text?.removeAll()
        }
        else
        {
            self.restriction?.startTime = startTimeTextBox.text ?? ""
            self.restriction?.endTime = endTimeTextBox.text ?? ""
        }

        if let res = self.restriction
        {
            delegate?.restrictionUpdated(restriction: res, index: self.index)
        }
    }

    ///https://publicaffairs.wustl.edu/assets/color-palettes/
    func changeUiToMatchDecision(decision: Int)
    {
        if decision == 0
        {
            type.backgroundColor = .white
            type.textColor = .black
            startTimeTextBox.isHidden = true
            helperLabel.isHidden = true
            endTimeTextBox.isHidden = true
            
        }
        else if decision == 1
        {
            type.backgroundColor = UIColor(hue: 359/360, saturation: 87/100, brightness: 64/100, alpha: 1.0) /* #a51417 */
            type.textColor = .white
            startTimeTextBox.isHidden = true
            helperLabel.isHidden = true
            endTimeTextBox.isHidden = true
        }
        else if decision == 2
        {
            type.backgroundColor = UIColor(hue: 0.5472, saturation: 1, brightness: 0.52, alpha: 1.0) /* #005f85 */
            type.textColor = .white
            startTimeTextBox.isHidden = false
            startTimeTextBox.placeholder = "Select Before Time"
            helperLabel.isHidden = true
            endTimeTextBox.isHidden = true
        }
        else if decision == 3
        {
            type.backgroundColor = UIColor(hue: 0.8222, saturation: 0.64, brightness: 0.4, alpha: 1.0) /* #622466 */
            type.textColor = .white
            startTimeTextBox.isHidden = false
            startTimeTextBox.placeholder = "Select After Time"
            helperLabel.isHidden = true
            endTimeTextBox.isHidden = true
        }
        else if decision == 4
        {
            type.backgroundColor = UIColor(hue: 0.0528, saturation: 0.81, brightness: 0.81, alpha: 1.0) /* #d15f27 */
            type.textColor = .white
            startTimeTextBox.isHidden = false
            startTimeTextBox.placeholder = "From"
            helperLabel.isHidden = false
            helperLabel.text = "and"
            endTimeTextBox.isHidden = false
            endTimeTextBox.placeholder = "To"
        }
        else if decision == 5
        {
            type.backgroundColor = UIColor(hue: 0.1222, saturation: 0.91, brightness: 0.97, alpha: 1.0) /* #f8be15 */
            type.textColor = .black
            startTimeTextBox.isHidden = false
            startTimeTextBox.placeholder = "From"
            helperLabel.isHidden = false
            helperLabel.text = "and"
            endTimeTextBox.isHidden = false
            endTimeTextBox.placeholder = "To"
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
        self.changeUiToMatchDecision(decision: row)
        self.changeDataModelBasedOnDecision(decision: row)
    }
}
