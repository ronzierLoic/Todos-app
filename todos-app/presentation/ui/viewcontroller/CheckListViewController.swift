//
//  ViewController.swift
//  todos-app
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {

    var checkItemList: [CheckListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkItemList.append(CheckListItem(text: "Je suis check", checked: true))
        self.checkItemList.append(CheckListItem(text: "Je suis pas check"))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.checkItemList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
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
    
}

private extension CheckListViewController {
    func configureCheckmark(for cell: UITableViewCell, withItem item: CheckListItem) {
        cell.accessoryType = item.checked ? .checkmark : .none
    }
    
    func configureText(for cell: UITableViewCell, withItem item: CheckListItem) {
        cell.textLabel?.text = item.text
    }
}

