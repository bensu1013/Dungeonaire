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

    
    override func didMove(to view: SKView) {
        
        
        let char1 = Warrior()
        let char2 = Warrior()
        let enemy = GoblinSpear()
        UserDatabase.main.party.units.append(char1)
        UserDatabase.main.party.units.append(char2)
        battleEngine.teamTwo.party.append(enemy)
        
        battleEngine.startBattle()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }
    
}
