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
    
    func showDrawn(_ cards: Hand, isPlayer: Bool, completion: @escaping () -> () )
    func takeAITurn()
    func updateHUD(health: ([Int], [Int]))
    func showEndTurn(completion: @escaping () -> () )
    
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
    
    private func incrementInitiative() {
        for unit in component.battleUnits {
            unit.initiativeIncrement()
        }
    }
    
    private func findReadyUnit() {
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
    
//    func prepareTurn() {
//        while component.readyUnit == nil {
//            findReadyUnit()
//            incrementInitiative()
//        }
//        let battleUnit = component.readyUnit!
//        
//        let hand = battleUnit.drawCards()
//        
//        // set hudlayer to reflect drawing cards 'hand'
//        if let _ = battleUnit.unit as? MonsterUnit {
//            showDrawn(hand, isPlayer: false)
//            
//        }
//        if let _ = battleUnit.unit as? PlayerUnit {
//            showDrawn(hand, isPlayer: true)
//        }
//        
//    }
    
    func prepareTurn(completion: @escaping () -> () ) {
        while component.readyUnit == nil {
            findReadyUnit()
            incrementInitiative()
        }
        let battleUnit = component.readyUnit!
        let hand = battleUnit.drawCards()
        
        // set hudlayer to reflect drawing cards 'hand'
        if let _ = battleUnit.unit as? MonsterUnit {
            showDrawn(hand, isPlayer: false) {
                completion()
            }
        }
        if let _ = battleUnit.unit as? PlayerUnit {
            showDrawn(hand, isPlayer: true) {
                completion()
            }
        }
        
    }
    
    func aiCalc() -> (SkillCard, Int) {
        let ai = AIBattleLogic()
        let aiChoice = ai.chooseCard(from: component.readyUnit!.hand!, team1: playerUnits, team2: enemyUnits)
        return (aiChoice.0, aiChoice.1)
    }
    
    func completeTurn(card: SkillCard, target: Int) {
        if let battleUnit = component.readyUnit {
            if let _ = battleUnit.unit as? MonsterUnit {

                battleUnit.useCard(card, target: playerUnits[target])
                
            }
            if let _ = battleUnit.unit as? PlayerUnit {
                battleUnit.useCard(card, target: enemyUnits[target])
                
            }
            battleUnit.completeTurn()
            updateHUD(health: unitsHealth())
        }
        endTurn()
    }
    
    func endTurn() {
        component.readyUnit = nil
        //reset hud to neutral
        showEndTurn {
            
        }
        
    }
    
}
