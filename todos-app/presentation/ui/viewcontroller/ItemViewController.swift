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
    
    var delegate: ItemViewControllerDelegate?
    var itemToEdit: CheckListItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if((itemToEdit) != nil){
            self.nameItemField.text = itemToEdit?.text
            self.navigationItem.title = "Item modification"
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
            delegate?.itemViewController(self, didFinishEditingItem: itemToEdit!)
        } else {
            delegate?.itemViewController(self, didFinishAddingItem: CheckListItem(text: self.nameItemField.text!))
        }
    }
    
}
