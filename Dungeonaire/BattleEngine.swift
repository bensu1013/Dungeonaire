//
//  BattleEngine.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

protocol BattleEngineDelegate: class {
    func healthChanges(team1: [Int], team2: [Int])
}

class BattleEngine {
    
    var teamOne = PlayerTeam()
    var teamTwo = MonsterTeam()
    var inputRequired = false
    var delegate: BattleEngineDelegate?
    
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

//MARK: initiatives and turns
extension BattleEngine {
    
    func startBattle() {
        //battle setup - graphical, data
        teamOne.startBattleInitiatives()
        teamTwo.startBattleInitiatives()
        prepareTurn()
    }
    
    func prepareTurn() {
        
        if teamTwo.isDefeated {
            print("winner")
        } else if teamOne.isDefeated {
            print("loser")
        }
        
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
        takeTurn()
    }
    
    func unitsHealth() -> ([Int], [Int]) {
        var team1 = [Int](), team2 = [Int]()
        for unit in teamOne.party {
            team1.append(unit.health)
        }
        for unit in teamTwo.party {
            team2.append(unit.health)
        }
        return (team1, team2)
    }
    
    func takeTurn() {
        if nextTeam() == 2 {
            inputRequired = false
            teamTwo.takeTurn() {
                //update hud
                let allHealth = self.unitsHealth()
                self.delegate?.healthChanges(team1: allHealth.0, team2: allHealth.1)
                self.prepareTurn()
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
