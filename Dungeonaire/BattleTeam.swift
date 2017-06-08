//
//  BattleTeam.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/3/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//


/*
 teams are responsible for keeping track of everything happening within the group
 initiatives are checked here and battleEngine will determine who goes first
 */


import Foundation

var turnThreshold = 100

class BattleTeam {
    
    var enemyTeam: BattleTeam?
    var currentUnit: Unit?
    var party = [Unit]()
    var isDefeated: Bool {
        get {
            for unit in party {
                if !unit.isDefeated {
                    return false
                }
            }
            return true
        }
    }
    
    func addTeamMember(unit: Unit) {
        party.append(unit)
        unit.team = self
    }
    
    func takeTurn(completion: @escaping () -> () ) {
        if let unit = currentUnit {
            unit.skills.activateSkill()
            unit.initiative -= turnThreshold
            currentUnit = nil
            checkInitiatives()
            completion()
        }
    }
    
    func recieveAssault(_ allDamage: [(Int, Double)]) {
        for target in allDamage {
            if target.0 < party.count {
                party[target.0].healthChanged(by: target.1)
            }
        }
    }
    
}

//MARK: team initiative methods
extension BattleTeam {
    
    func startBattleInitiatives() {
        for unit in party {
            let initRoll = Int(arc4random_uniform(UInt32(20)))
            unit.initiative = initRoll + unit.attributes.dexterity
        }
    }
    
    func checkInitiatives() {
        var highestInitUnit: Unit? = nil
        for unit in party {
            if unit.initiative >= turnThreshold && !unit.isDefeated {
                if let highUnit = highestInitUnit {
                    if unit.initiative > highUnit.initiative {
                        highestInitUnit = unit
                    }
                } else {
                    highestInitUnit = unit
                }
            }
        }
        currentUnit = highestInitUnit
    }
    
    func incrementInitiatives() {
        for unit in party {
            if !unit.isDefeated {
                unit.initiative += unit.attributes.dexterity
            }
        }
    }

}
