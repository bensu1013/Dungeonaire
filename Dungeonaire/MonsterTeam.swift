//
//  EnemyTeam.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/5/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class MonsterTeam: BattleTeam {
    
    override func takeTurn(completion: @escaping () -> ()) {
        if let unit = currentUnit {
            chooseSkill(for: unit)
            unit.initiative -= turnThreshold
            currentUnit = nil
            checkInitiatives()
            completion()
        }
    }
    
    private func chooseSkill(for unit: Unit) {
        unit.skills.select(.first)
        unit.sprite.changeState(to: .attack)
        //check list of skills vs enemyteams units
    }
    
}
