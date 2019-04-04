//
//  AddItemTableViewController.swift
//  todos-app
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

protocol ItemViewControllerDelegate: class {
    func itemViewControllerDidCancel(_ controller: ItemViewController)
    func itemViewController(_ controller: ItemViewController, didFinishAddingItem item: CheckListItem)
    func itemViewController(_ controller: ItemViewController, didFinishEditingItem item: CheckListItem)
}

class ItemViewController: UITableViewController , UITextFieldDelegate {
    
    @IBOutlet weak var nameItemField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var switchRemind: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var datePickerCell: UITableViewCell!
    @IBOutlet weak var dateLabelCell: UITableViewCell!
    
    var delegate: ItemViewControllerDelegate?
    var itemToEdit: CheckListItem?
    var itemToCreate: CheckListItem?
    var isDatePickerVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if((itemToEdit) != nil){
            self.nameItemField.text = itemToEdit?.text
            self.navigationItem.title = "Item modification"
            dateLabel.text = formatDate(date: (itemToEdit?.dueDate)!)
        } else {
            itemToCreate = CheckListItem(text: "")
            dateLabel.text = formatDate(date: (itemToCreate?.dueDate)!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameItemField.becomeFirstResponder()
        self.doneButton.isEnabled = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = nameItemField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        if newString?.isEmpty ?? true {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        return true
    }
    
    @IBAction func cancelClick(_ sender: Any){
        delegate?.itemViewControllerDidCancel(self)
    }
    
    @IBAction func doneClick(_ sender: Any) {
        if(itemToEdit != nil){
            itemToEdit?.text = self.nameItemField.text!
            itemToEdit?.shouldRemind = switchRemind.isOn
//            itemToEdit?.scheduleNotification()
            delegate?.itemViewController(self, didFinishEditingItem: itemToEdit!)
        } else {
            itemToCreate?.text = self.nameItemField.text!
            itemToCreate?.shouldRemind = switchRemind.isOn
            itemToCreate?.dueDate = datePicker.date
//            itemToCreate?.scheduleNotification()
            delegate?.itemViewController(self, didFinishAddingItem: itemToCreate!)
        }
    }

 
    func formatDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy, HH:mm"
        formatter.locale = Locale(identifier: "en")
        let dateString = formatter.string(from: date)
        
        return dateString
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if(indexPath.row == 1 && indexPath.section == 1){
            return indexPath
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 && indexPath.row == 2 {
            return datePickerCell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            if(isDatePickerVisible) {
                return 3
            }
            return 2
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 1 && indexPath.row == 2){
           return datePicker.intrinsicContentSize.height
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
        if(isDatePickerVisible) {
            hideDatePicker()
        } else {
            showDatePicker()
        }
        tableView.endUpdates()
    }

    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1 && indexPath.row == 2 {
            return super.tableView(tableView, indentationLevelForRowAt: IndexPath(row: 1, section: 1))
        }
        return super.tableView(tableView, indentationLevelForRowAt: indexPath)
    }
    
    @IBAction func dateChange(_ sender: Any) {
        dateLabel.text = formatDate(date: datePicker.date)
    }
    
    func showDatePicker() {
        isDatePickerVisible = true;
        if let dateCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1)) {
            dateCell.detailTextLabel?.textColor = .red
        }
        
        tableView.insertRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
        tableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .none)
    }
    
    func hideDatePicker() {
        isDatePickerVisible = false;
        if let dateCell = tableView.cellForRow(at: IndexPath(row: 1, section: 1)) {
            dateCell.detailTextLabel?.textColor = .gray
        }
        
        tableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .none)
        tableView.deleteRows(at: [IndexPath(row: 2, section: 1)], with: .automatic)
    }
}
