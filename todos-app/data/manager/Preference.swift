//
//  Preference.swift
//  todos-app
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit


class Preference {
    static var instance = Preference()
    
    func nextCheckListItemID() -> Int {
        let id = UserDefaults.standard.integer(forKey: UserDefaultKey.checklistItemID)
        let nextId = id + 1
        UserDefaults.standard.set(nextId, forKey: UserDefaultKey.checklistItemID)
        return nextId
    }
    
    func firstLaunch() -> Bool {
        UserDefaults.standard.register(defaults: [UserDefaultKey.firstLaunch : true])
        let firstLaunch = UserDefaults.standard.bool(forKey: UserDefaultKey.firstLaunch)
        if(firstLaunch == true){
            UserDefaults.standard.set(0, forKey: UserDefaultKey.checklistItemID)
            UserDefaults.standard.set(false, forKey: UserDefaultKey.firstLaunch)
            return true
        }
        return false
    }
    
    func handleFirstLaunch() {
       
        
    }
}
