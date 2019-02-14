//
//  AddItemTableViewController.swift
//  todos-app
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem)
}

class AddItemViewController: UITableViewController , UITextFieldDelegate {
    
    @IBOutlet weak var nameItemField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var delegate: AddItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        delegate?.addItemViewControllerDidCancel(self)
    }
    
    @IBAction func doneClick(_ sender: Any) {
        print(self.nameItemField.text!)
        delegate?.addItemViewController(self, didFinishAddingItem: CheckListItem(text: self.nameItemField.text!))
    }
    
}
