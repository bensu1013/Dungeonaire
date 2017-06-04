//
//  Character.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class Unit {
    
    var selectedSkill: Skill?
    var initiative = 0
    var skills = [Skill]()
    var attributes = Attributes()
    var health = 10
        
    func selectSkill(at index: Int) {
        selectedSkill = skills[index]
    }
    func takeTurn(handler: @escaping (Skill?) -> () ) {
        print("unit")
    }
    
    func update(dt: TimeInterval) {
        print("unit update")
    }
    
    
    
}
