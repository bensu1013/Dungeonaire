//
//  BattleStation.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/13/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct BattleStoredComponents {
    var isEngaged: Bool = false
    var battleUnits = [BattleComponent]()
    var readyUnit: BattleComponent?
}

protocol BattleStation: class {

    var playerUnits: [Unit] { get set }
    var enemyUnits: [Unit] { get set }
    var component: BattleStoredComponents { get set }
    
    func showDrawn(_ cards: Hand, isPlayer: Bool)
    func turnComplete()
}

extension BattleStation {
    
    func generateEnemies(array: [Unit]) {
        enemyUnits = array
    }
    
    func startBattle() {
        for unit in playerUnits {
            component.battleUnits.append(unit.battle)
        }
        for unit in enemyUnits {
            component.battleUnits.append(unit.battle)
        }
        for unit in component.battleUnits {
            unit.initiativeStart()
        }
    }
    
    func incrementInitiative() {
        for unit in component.battleUnits {
            unit.initiativeIncrement()
        }
    }
    
    func findReadyUnit() {
        var highInitUnit: BattleComponent?
        for unit in component.battleUnits {
            if unit.readyForTurn() {
                if let highUnit = highInitUnit {
                    if unit.initiative > highUnit.initiative {
                        highInitUnit = unit
                    } else if unit.initiative == highUnit.initiative &&
                        unit.speed < highUnit.speed {
                        highInitUnit = unit
                    }
                } else {
                    highInitUnit = unit
                }
            }
            
        }
        component.readyUnit = highInitUnit
    }
    
    func unitsHealth() -> ([Int], [Int]) {
        var team1 = [Int](), team2 = [Int]()
        for unit in playerUnits {
            team1.append(unit.health)
        }
        for unit in enemyUnits {
            team2.append(unit.health)
        }
        return (team1, team2)
    }
    
    func prepareTurn() {
        while component.readyUnit == nil {
            findReadyUnit()
            incrementInitiative()
        }
        if let battleUnit = component.readyUnit {
            let hand = battleUnit.drawCards()
            // set hudlayer to reflect drawing cards 'newHand'
            
            if let _ = battleUnit.unit as? MonsterUnit {
                showDrawn(hand, isPlayer: false)
            }
            if let _ = battleUnit.unit as? PlayerUnit {
                showDrawn(hand, isPlayer: true)
            }
        }
    }
    
    func completeTurn(skill: SkillSlot, target: Int) {
        if let battleUnit = component.readyUnit {
            if let _ = battleUnit.unit as? MonsterUnit {
                if let hand = battleUnit.hand {
                    //deal damage with selected skillcard
                    if skill.rawValue == 0 {
                        print(hand.0.temp)
                    }
                }
            }
            if let _ = battleUnit.unit as? PlayerUnit {
                
            }
            battleUnit.completeTurn()
        }
        endTurn()
    }
 
    func endTurn() {
        component.readyUnit = nil
        //reset hud to neutral
        turnComplete()
    }
    
    
}
