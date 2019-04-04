//
//  StorageManager.swift
//  todos-app
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import UserNotifications

class DataModel {
    static var instance = DataModel()
    
    static var documentDirectory: URL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)!
    static var dataFileUrl: URL = documentDirectory.appendingPathComponent("Checklist").appendingPathExtension("json")
    
    var lists: [CheckList] = []
    
    init() {
        NotificationCenter.default.addObserver( self,selector: #selector(self.saveCheckList), name: UIApplication.didEnterBackgroundNotification, object: nil)
        loadCheckListItems()
        print((FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first)!)
        if(Preference.instance.firstLaunch() == true) {
            lists.append(CheckList(name: "Edit your first item, Swipe me to delete"))
        }
    }
    
    @objc func saveCheckList() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(lists)
        try? data?.write(to: DataModel.dataFileUrl)
    }
    
    func loadCheckListItems() {
        if let data = try? Data(contentsOf: DataModel.dataFileUrl),
            let list = try? JSONDecoder().decode([CheckList].self, from: data) {
            self.lists = list
        }
    }
    
    func sortCheckLists() {
        lists.sort { $0.name.localizedCompare($1.name) == .orderedAscending }
    }
    
//    func addNotification(item: CheckListItem) {
//        
//        let content = UNMutableNotificationContent()
//        content.title = item.text
//        
//        let units: Set<Calendar.Component> = [.minute, .hour, .day, .month, .year]
//        let dateComponents = Calendar.current.dateComponents(units, from: item.dueDate)
//        
//        
//        // Create the trigger as a repeating event.
//        let trigger = UNCalendarNotificationTrigger(
//            dateMatching: dateComponents, repeats: true)
//        
//        let uuidString = UUID().uuidString
//        let request = UNNotificationRequest(identifier: uuidString,
//                                            content: content,
//                                            trigger: trigger)
//        
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.add(request) { (error) in
//            if error != nil {
//                // Handle any errors.
//            }
//        }
//    }
//    
//    
//    func removeNotification() {
//        
//    }
}
