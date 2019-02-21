//
//  ViewController.swift
//  todos-app
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, AddItemViewControllerDelegate {
    var checkItemList: [CheckListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkItemList.append(CheckListItem(text: "Je suis check", checked: true))
        self.checkItemList.append(CheckListItem(text: "Je suis pas check"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addItem"){
            let addItemViewController = (segue.destination as! UINavigationController).topViewController as! AddItemViewController
            addItemViewController.delegate = self
        } else if (segue.identifier == "editItem") {
           
            if let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell){
                let addItemViewController = (segue.destination as! UINavigationController).topViewController as! AddItemViewController
                addItemViewController.itemToEdit = checkItemList[indexPath.row]
                addItemViewController.delegate = self
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.checkItemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath) as! CheckMarkViewCell
        let item = self.checkItemList[indexPath.row]
        self.configureText(for: cell, withItem: item)
        self.configureCheckmark(for: cell, withItem: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.checkItemList[indexPath.row].toogleCheck()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.checkItemList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: CheckListItem) {
        self.dismiss(animated: false, completion: nil)
        self.checkItemList.append(item)
        tableView.insertRows(at: [IndexPath(row: self.checkItemList.count-1, section: 0)], with: .none)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: CheckListItem) {
        self.dismiss(animated: false, completion: nil)
        if let row = self.checkItemList.firstIndex(where: {$0 === item}) {
            self.checkItemList[row] = item
            tableView.reloadRows(at: [IndexPath(row: row, section:0)], with: .none)
        }
    }
    
}

extension CheckListViewController {
    func configureCheckmark(for cell: CheckMarkViewCell, withItem item: CheckListItem) {
        cell.checkMarkLabel.isHidden = !item.checked
    }
    
    func configureText(for cell: CheckMarkViewCell, withItem item: CheckListItem) {
        cell.nameLabel.text = item.text
    }
}

