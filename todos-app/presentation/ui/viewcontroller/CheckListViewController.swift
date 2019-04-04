//
//  ViewController.swift
//  todos-app
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit


class CheckListViewController: UITableViewController, ItemViewControllerDelegate {
   
    
    var checkList: CheckList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.checkList.name
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addItem"){
            let addItemViewController = (segue.destination as! UINavigationController).topViewController as! ItemViewController
            addItemViewController.delegate = self
        } else if (segue.identifier == "editItem") {
            
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell){
                let addItemViewController = (segue.destination as! UINavigationController).topViewController as! ItemViewController
                addItemViewController.itemToEdit = checkList.items[indexPath.row]
                addItemViewController.delegate = self
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.checkList.items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath) as! CheckMarkViewCell
        let item = self.checkList.items[indexPath.row]
        self.configureText(for: cell, withItem: item)
        self.configureCheckmark(for: cell, withItem: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.checkList.items[indexPath.row].toogleCheck()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.checkList.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            DataModel.instance.saveCheckList()
        }
    }
    
    func itemViewControllerDidCancel(_ controller: ItemViewController) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func itemViewController(_ controller: ItemViewController, didFinishAddingItem item: CheckListItem) {
        self.dismiss(animated: false, completion: nil)
        self.checkList.items.append(item)
        tableView.insertRows(at: [IndexPath(row: self.checkList.items.count-1, section: 0)], with: .none)
        DataModel.instance.saveCheckList()
    }
    
    func itemViewController(_ controller: ItemViewController, didFinishEditingItem item: CheckListItem) {
        self.dismiss(animated: false, completion: nil)
        if let row = self.checkList.items.firstIndex(where: {$0 === item}) {
            self.checkList.items[row] = item
            tableView.reloadRows(at: [IndexPath(row: row, section:0)], with: .none)
            DataModel.instance.saveCheckList()
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
