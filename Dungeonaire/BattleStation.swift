//
//  BattleStation.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/13/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct BattleStoredComponents {

    var playerUnits = [Unit]()
    var enemyUnits = [Unit]()
    var battleUnits = [BattleComponent]()
    var readyUnit: BattleComponent?
    
}

protocol BattleStation: class {

    var component: BattleStoredComponents { get set }
    
}

extension BattleStation {
    
    //MARK: -Computed Properties
    var playerUnits: [Unit] {
        get {
            return component.playerUnits
        }
        set {
            component.playerUnits = newValue
        }
    }
    var enemyUnits: [Unit] {
        get {
            return component.enemyUnits
        }
        set {
            component.enemyUnits = newValue
        }
    }
    
    var battleUnits: [BattleComponent] {
        get {
            return component.battleUnits
        }
        set {
            component.battleUnits = newValue
        }
    }
    
    var readyUnit: BattleComponent? {
        get {
            return component.readyUnit
        }
        set {
            component.readyUnit = newValue
        }
    }
    
    //MARK: -Battle Methods
    func startBattle() {
        for unit in playerUnits {
            unit.cards.startBattle()
            battleUnits.append(unit.battle)
        }
        for unit in enemyUnits {
            unit.cards.startBattle()
            battleUnits.append(unit.battle)
        }
        for unit in battleUnits {
            unit.initiativeStart()
        }
    }
    
    private func incrementInitiative() {
        for unit in battleUnits {
            unit.initiativeIncrement()
        }
    }
    
    private func findReadyUnit() {
        var highInitUnit: BattleComponent?
        for unit in battleUnits {
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
        readyUnit = highInitUnit
    }
    
    func unitsHealth() -> ([Int], [Int]) {
        var team1 = [Int](), team2 = [Int]()
        for unit in playerUnits {
            team1.append(unit.battle.health)
        }
        for unit in enemyUnits {
            team2.append(unit.battle.health)
        }
        return (team1, team2)
    }
    
    func prepareTurn(completion: @escaping (Team) -> () ) {
        while readyUnit == nil {
            findReadyUnit()
            incrementInitiative()
        }
        let battleUnit = readyUnit!
        
        // set hudlayer to reflect drawing cards 'hand'
        completion(battleUnit.team)
    }
    
    func drawCards() -> Hand {
        let battleUnit = readyUnit!
        return battleUnit.drawCards()
    }
    
    func teamDefeated(_ team: Team) -> Bool {
        if team == .team1 {
            for unit in playerUnits {
                if !unit.battle.isDefeated {
                    return false
                }
            }
        } else {
            for unit in enemyUnits {
                if !unit.battle.isDefeated {
                    return false
                }
            }
        }
        return true
    }
    
    func wonBattle() -> Team? {
        if teamDefeated(.team1) {
            return .team2
        } else if teamDefeated(.team2) {
            return .team1
        }
        return nil
    }
    
    func aiCalc() -> (SkillCard, Unit) {
        let ai = AIBattleLogic()
        let aiChoice = ai.chooseCard(from: readyUnit!.hand!, team1: playerUnits, team2: enemyUnits)
        return (aiChoice.0, aiChoice.1)
    }
    
    func completeTurn(card: SkillCard, target: Unit) {
        if let battleUnit = readyUnit {
            battleUnit.useCard(card, target: target)
            battleUnit.completeTurn()
        }
        endTurn()
    }
    
    func endTurn() {
        readyUnit = nil
        //reset hud to neutral
        
        
    }
    
}
