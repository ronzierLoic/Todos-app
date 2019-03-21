//
//  IconAsset.swift
//  todos-app
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

enum IconAsset : String, Codable{
    case Appointments
    case Birthdays
    case Chores
    case Drinks
    case Folder
    case Groceries
    case Inbox
    case NoIcon = "No Icon"
    case Photos
    case Trips
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
}

func getIconAsset() -> [IconAsset] {
    let icons = [IconAsset.Appointments,
                 IconAsset.Birthdays,
                 IconAsset.Chores,
                 IconAsset.Drinks,
                 IconAsset.Folder,
                 IconAsset.Groceries,
                 IconAsset.Inbox,
                 IconAsset.NoIcon,
                 IconAsset.Photos,
                 IconAsset.Trips]
    return icons
}
