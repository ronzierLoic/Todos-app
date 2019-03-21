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
    @IBOutlet weak var iconView: UIImageView!
    
    var delegate: AllListViewController?
    var itemToEdit: CheckList?
    var itemToCreate: CheckList = CheckList(name: "", icon: IconAsset.Folder)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "iconChoose"){
            let addItemViewController = segue.destination as! IconPickerViewController
            addItemViewController.setIconHandler = self.setIcon
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if((itemToEdit) != nil){
            self.nameField.text = itemToEdit?.name
            self.navigationItem.title = "Item modification"
            self.doneButton.isEnabled = true
            self.iconView.image = self.itemToEdit?.icon.image
        } else {
            self.itemToCreate.icon = IconAsset.Folder
            self.iconView.image = IconAsset.Folder.image
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameField.becomeFirstResponder()
        if((itemToEdit) != nil){
            self.doneButton.isEnabled = true
        } else {
            self.doneButton.isEnabled = false
        }
        
        if((nameField.text) != ""){
            self.doneButton.isEnabled = true
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func doneClick(_ sender: Any) {
        if(itemToEdit != nil){
            itemToEdit?.name = self.nameField.text!
            delegate?.listDetailViewController(self, didFinishEditingItem: itemToEdit!)
        } else {
            itemToCreate.name = nameField.text!
            delegate?.listDetailViewController(self, didFinishAddingItem: itemToCreate)
        }
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        delegate?.listDetailControllerDidCancel(self)
    }
}

extension ListDetailViewController {
    
    func setIcon(view: UIViewController, icon: IconAsset) {
        self.navigationController?.popViewController(animated: true)
        if(itemToEdit != nil){
            self.itemToEdit?.icon = icon
        } else {
            self.itemToCreate.icon = icon
        }
        self.iconView.image = icon.image
    }
    
}
