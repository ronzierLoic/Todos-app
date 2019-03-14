//
//  CheckList.swift
//  todos-app
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation

class CheckList: Codable {
    var name: String
    var items: [CheckListItem]
    
    init(name: String, items: [CheckListItem] = []){
        self.name = name
        self.items = items
        
    }
   
    func uncheckedItemsCount() -> Int {
        if(items.count == 0){
            return -1
        } else {
            return items.filter({$0.checked == false}).count
        }
    }
}
