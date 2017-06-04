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
    var teamOne = BattleTeam()
    var teamTwo = BattleTeam()
    
    init() {
        teamOne.party = UserDatabase.main.party
        teamOne.enemyTeam = teamTwo
        
        teamTwo.enemyTeam = teamOne
    }
    
    func playerTurn() {
        if let unit = currentUnit as? PlayerUnit {
            unit.takeTurn(handler: { (skill) in
                if let skill = skill {
                    let skillAmount = skill.activate(modifier: Double(unit.attributes.strength))
                    if skill.type == .attack {
                        for target in skill.targets {
                            if target < self.teamTwo.party.count {
                                self.teamTwo.party[target].health -= Int(skillAmount)
                            }
                        }
                    }
                }
            })
        }
    }
    
    //probably remove update and turn in to a while loop for finding next unit action
    func update(dt: TimeInterval) {
        if let unit = currentUnit {
            if let enemy = unit as? EnemyUnit {
                enemy.takeTurn(handler: { (skill) in
                    
                })
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
        for playerUnit in teamOne.party {
            let initRoll = Int(arc4random_uniform(UInt32(20)))
            playerUnit.initiative = initRoll + playerUnit.attributes.dexterity
        }
        for enemyUnit in teamTwo.party {
            let initRoll = Int(arc4random_uniform(UInt32(20)))
            enemyUnit.initiative = initRoll + enemyUnit.attributes.dexterity
        }
    }
    
    func checkInitiatives() {
        var highestInitUnit: Unit? = nil
        for enemyUnit in teamTwo.party {
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
        for playerUnit in teamOne.party {
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
        for unit in teamOne.party {
            unit.initiative += unit.attributes.dexterity
        }
        for unit in teamTwo.party {
            unit.initiative += unit.attributes.dexterity
        }
    }
    
}
