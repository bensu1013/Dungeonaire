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
        let enemy1 = GoblinSpear()
        let enemy2 = GoblinSpear()
        UserDatabase.main.party.units.append(char1)
        UserDatabase.main.party.units.append(char2)
        
        battleEngine.load(first: UserDatabase.main.party.units, second: [enemy1, enemy2])
        
        battleEngine.startBattle()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if battleEngine.inputRequired {
            //ASDLKVJASDLKJASDLKFJ HEREHEH
            
            battleEngine.teamOne.currentUnit?.skills.select(.first)
            battleEngine.teamOne.takeTurn() {
                self.battleEngine.prepareTurn()
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
        
        
        
        
    }
    
}
