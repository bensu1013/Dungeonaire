//
//  WarriorClass.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


class Warrior: Squib {
    
    
    override func update(dt: TimeInterval) {
        if let _ = equipment["weapon"] as? Weapon {
            print("weapon")
        }
    }
}
