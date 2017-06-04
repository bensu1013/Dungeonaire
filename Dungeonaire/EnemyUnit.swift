//
//  EnemyUnit.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class EnemyUnit: Unit {
    
    var selectedSkill: Skill? = nil
    
    override func takeTurn(handler: @escaping (Skill?) -> () ) {
        //use AI to choose skill to use
//        print("freedom@@@@@@@\n\(health)")
    }
    
    
}
