//
//  ListDetailViewController.swift
//  todos-app
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate {
    func listDetailControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    
    var delegate: AllListViewController?
    var itemToEdit: CheckList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if((itemToEdit) != nil){
            self.nameField.text = itemToEdit?.name
            self.navigationItem.title = "Item modification"
            self.doneButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameField.becomeFirstResponder()
        if((itemToEdit) != nil){
            self.doneButton.isEnabled = true
        } else {
            self.doneButton.isEnabled = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nsString = nameField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        if newString?.isEmpty ?? true {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
        return true
    }
    
    @IBAction func doneClick(_ sender: Any) {
        if(itemToEdit != nil){
            itemToEdit?.name = self.nameField.text!
            delegate?.listDetailViewController(self, didFinishEditingItem: itemToEdit!)
        } else {
            delegate?.listDetailViewController(self, didFinishAddingItem: CheckList(name: nameField.text!))
        }
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        delegate?.listDetailControllerDidCancel(self)
    }
}
