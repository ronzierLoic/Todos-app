//
//  CheckListItem.swift
//  todos-app
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation
import UserNotifications

class CheckListItem: Codable {
    var itemId: Int
    var text: String
    var checked: Bool
    var dueDate: Date
    var shouldRemind: Bool
    
    init(text: String, checked: Bool = false, shouldRemind: Bool = false, dueDate: Date = Date()){
        self.text = text
        self.checked = checked
        self.shouldRemind = shouldRemind
        self.dueDate = dueDate
        self.itemId = Preference.instance.nextCheckListItemID()
    }
    
    init(text:String, checked: Bool, shouldRemind: Bool, dueDate: Date, itemID: Int){
        self.text = text
        self.checked = checked
        self.shouldRemind = shouldRemind
        self.dueDate = dueDate
        self.itemId = itemID
    }
    
    func toogleCheck() {
        self.checked = !self.checked
    }
    
//    func scheduleNotification() {
//        DataModel.instance.addNotification(item: self);
//    }
}
