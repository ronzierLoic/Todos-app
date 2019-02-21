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
   
}
