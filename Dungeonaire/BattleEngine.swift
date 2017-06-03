//
//  BattleEngine.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

private var turnThreshold = 100

class BattleEngine {
    
    var currentUnit: Unit?
    var playerTeam = PlayerDatabase.main
    var enemyTeam = [EnemyUnit]()
    
    
    
    
    
    
    
    
    func update(dt: TimeInterval) {
        if let unit = currentUnit {
            if let enemy = unit as? EnemyUnit {
                enemy.takeTurn()
                currentUnit = nil
            }
            if let _ = unit as? PlayerUnit {
                //setup HUDLayer to reflect unit
            }
        } else {
            incrementInitiatives()
            checkInitiatives()
        }
        
    }
    
}

//MARK: initiatives
extension BattleEngine {
    
    //figure out turns based on dexterity
    func startBattleInitiatives() {
        for playerUnit in playerTeam.party.units {
            let initRoll = Int(arc4random_uniform(UInt32(20)))
            playerUnit.initiative = initRoll + playerUnit.attributes.dexterity
        }
        for enemyUnit in enemyTeam {
            let initRoll = Int(arc4random_uniform(UInt32(20)))
            enemyUnit.initiative = initRoll + enemyUnit.attributes.dexterity
        }
    }
    
    func checkInitiatives() {
        var highestInitUnit: Unit? = nil
        for enemyUnit in enemyTeam {
            if enemyUnit.initiative >= turnThreshold {
                if let unit = highestInitUnit {
                    if enemyUnit.initiative > unit.initiative {
                        highestInitUnit = enemyUnit
                    }
                } else {
                    highestInitUnit = enemyUnit
                }
            }
        }
        for playerUnit in playerTeam.party.units {
            if playerUnit.initiative >= turnThreshold {
                if let unit = highestInitUnit {
                    if playerUnit.initiative > unit.initiative {
                        highestInitUnit = playerUnit
                    }
                } else {
                    highestInitUnit = playerUnit
                }
            }
        }
        if let unit = highestInitUnit {
            unit.initiative -= turnThreshold
            currentUnit = unit
        }
    }
    
    func incrementInitiatives() {
        for unit in playerTeam.party.units {
            unit.initiative += unit.attributes.dexterity
        }
        for unit in enemyTeam {
            unit.initiative += unit.attributes.dexterity
        }
    }
    
}
