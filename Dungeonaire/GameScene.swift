//
//  GameScene.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let battleEngine = BattleEngine()
    var frameTime: Double = 0
    
    override func didMove(to view: SKView) {
        
        
        let char1 = Warrior()
        let char2 = Warrior()
        let enemy = GoblinSpear()
        UserDatabase.main.party.units.append(char1)
        UserDatabase.main.party.units.append(char2)
        
        battleEngine.load(first: UserDatabase.main.party.units, second: [enemy])
        
        battleEngine.startBattle()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if battleEngine.inputRequired {
            battleEngine.teamOne.currentUnit?.selectSkill(at: 0)
            battleEngine.teamOne.takeTurn() {
                self.battleEngine.prepareNextTurn()
            }
        }
        
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if frameTime == 0 {
            frameTime = currentTime
        } else {
            frameTime += currentTime
        }
        
        if frameTime >= 10 {
            frameTime -= 10
            
            print("Warrior : \(battleEngine.teamOne.party[0].health)")
            print("Goblin : \(battleEngine.teamTwo.party[0].health)\n")
            
        }
        
        
        
    }
    
}
