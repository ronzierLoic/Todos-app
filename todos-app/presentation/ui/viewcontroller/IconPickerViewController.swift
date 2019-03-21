//
//  IconPickerViewController.swift
//  todos-app
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {

    var setIconHandler: ((UIViewController,IconAsset) -> ())!
    var icons: [IconAsset] = getIconAsset()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
        cell.imageView?.image = icons[indexPath.row].image
        cell.textLabel?.text = icons[indexPath.row].rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        setIconHandler(self,icons[indexPath.row])
    }
    
}
