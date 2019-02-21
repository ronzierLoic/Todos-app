//
//  CheckListItem.swift
//  todos-app
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation

class CheckListItem: Codable {
    var text: String
    var checked: Bool
    
    init(text: String, checked: Bool = false){
        self.text = text
        self.checked = checked
        
    }
    
    func toogleCheck() {
        self.checked = !self.checked
    }
}
