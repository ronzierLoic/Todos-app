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
    var icon: IconAsset
    
    init(name: String, items: [CheckListItem] = [], icon: IconAsset = IconAsset.NoIcon){
        self.name = name
        self.items = items
        self.icon = IconAsset.NoIcon
    }
   
    func uncheckedItemsCount() -> Int {
        return items.filter({$0.checked == false}).count
    }
}
