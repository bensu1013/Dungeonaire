//
//  WarriorClass.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


class Warrior: PlayerUnit {
    
    override init() {
        super.init()
        
    }
    
    override func update(dt: TimeInterval) {
        if let weapon = equipment.weapon {
            print(weapon.damage)
        }
        
    }
}
