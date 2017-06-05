//
//  BattleEngine.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation


class BattleEngine {
    
    var teamOne = PlayerTeam()
    var teamTwo = MonsterTeam()
    var inputRequired = false
    
    
    init() {
        
    }
    
    func load(first team1: [Unit], second team2: [Unit]) {
        for unit in team1 {
            teamOne.addTeamMember(unit: unit)
        }
        for unit in team2 {
            teamTwo.addTeamMember(unit: unit)
        }
        
        teamOne.enemyTeam = teamTwo
        teamTwo.enemyTeam = teamOne
    }
    
    
}

//MARK: initiatives
extension BattleEngine {
    
    func startBattle() {
        teamOne.startBattleInitiatives()
        teamTwo.startBattleInitiatives()
        prepareNextTurn()
    }
    
    func prepareNextTurn() {
        
        for unit in teamOne.party {
            print("Player - Init: \(unit.initiative) // Health: \(unit.health)")
        }
        for unit in teamTwo.party {
            print("Monster - Init: \(unit.initiative) // Health: \(unit.health)")
        }
        
        while !hasUnitReady() {
            teamOne.incrementInitiatives()
            teamTwo.incrementInitiatives()
            teamOne.checkInitiatives()
            teamTwo.checkInitiatives()
        }
        if nextTeam() == 2 {
            inputRequired = false
            teamTwo.takeTurn() {
                self.prepareNextTurn()
            }
        } else {
            //prepare for player
            inputRequired = true
        }
    }
    
    func nextTeam() -> Int {
        guard let a = teamOne.currentUnit else {
            return 2
        }
        guard let b = teamTwo.currentUnit else {
            return 1
        }
        return a.initiative >= b.initiative ? 1 : 2
    }
    
    func hasUnitReady() -> Bool {
        if let _ = teamOne.currentUnit {
            return true
        }
        if let _ = teamTwo.currentUnit {
            return true
        }
        return false
    }
    
}
