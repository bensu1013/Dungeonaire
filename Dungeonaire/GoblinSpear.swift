//
//  GoblinSpear.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class GoblinSpear: EnemyUnit {
    
    override init() {
        super.init()
        attributes.strength = 4
        attributes.dexterity = 6
        attributes.vitality = 3
        attributes.wisdom = 2
        attributes.luck = 2
    }
    
    
    override func update(dt: TimeInterval) {
        print("goblin unit")
    }
    
}
