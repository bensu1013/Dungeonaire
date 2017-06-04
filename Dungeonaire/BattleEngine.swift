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
    
    var teamOne = BattleTeam()
    var teamTwo = BattleTeam()
    
    init() {
        teamOne.party = UserDatabase.main.party.units
        teamOne.enemyTeam = teamTwo
        
        teamTwo.enemyTeam = teamOne
    }
    
    func playerTurn() {
        
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
        while !hasUnitReady() {
            teamOne.incrementInitiatives()
            teamTwo.incrementInitiatives()
            teamOne.checkInitiatives()
            teamTwo.checkInitiatives()
        }
        if nextTeam() == 2 {
            //skill needs to be chosen
            
            //target for skill picked
            
            //effect of skill applied
            
            //initiative reduced and check for other potential turns
            
        } else {
            //prepare for player
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
