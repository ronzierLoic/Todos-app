//
//  AllListViewController.swift
//  todos-app
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController, ListDetailViewControllerDelegate {
    static var documentDirectory: URL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)!
    static var dataFileUrl: URL = documentDirectory.appendingPathComponent("Checklist").appendingPathExtension("json")
    
    var lists = DataModel.instance.lists
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailList"){            
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell){
                let checkListViewController = segue.destination as! CheckListViewController
                checkListViewController.checkList = lists[indexPath.row]
            }
        } else if (segue.identifier == "addItemList") {
            let listDetailViewController = (segue.destination as! UINavigationController).topViewController as! ListDetailViewController
            listDetailViewController.delegate = self
        } else if (segue.identifier == "editItemList") {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell){
                let listDetailViewController = (segue.destination as! UINavigationController).topViewController as! ListDetailViewController
                listDetailViewController.itemToEdit = lists[indexPath.row]
                listDetailViewController.delegate = self
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.lists.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func listDetailControllerDidCancel(_ controller: ListDetailViewController) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingItem item: CheckList) {
        self.dismiss(animated: false, completion: nil)
        self.lists.append(item)
        tableView.insertRows(at: [IndexPath(row: self.lists.count-1, section: 0)], with: .none)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingItem item: CheckList) {
        self.dismiss(animated: false, completion: nil)
        if let row = self.lists.firstIndex(where: {$0 === item}) {
            self.lists[row] = item
            tableView.reloadRows(at: [IndexPath(row: row, section:0)], with: .none)
        }
    }

}

extension AllListViewController {
    
  
    
}
