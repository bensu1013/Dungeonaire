//
//  PlayerUnit.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class PlayerUnit: Unit {
    
    var selectedSkill: Skill? = nil
    var equipment = EquipmentController()
    
    func selectSkill(_ index: Int) {
        selectedSkill = skills[index]
    }
}
