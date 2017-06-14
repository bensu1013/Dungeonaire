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
}

extension BattleStation {
    
    func generateEnemies(array: [Unit]) {
        enemyUnits = array
    }
    
    func startBattle() {
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
            incrementInitiative()
            findReadyUnit()
        }
        if let battleUnit = component.readyUnit {
            let newHand = battleUnit.drawCards()
            // set hudlayer to reflect drawing cards 'newHand'
            //
            
        }
    }
    
    func takeTurn() {
        if let battleUnit = component.readyUnit {
            if let _ = battleUnit.unit as? MonsterUnit {
                
            }
        }
    }
 
    func endTurn() {
        
    }
    
    
}
