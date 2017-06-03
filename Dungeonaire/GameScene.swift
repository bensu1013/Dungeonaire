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
        
        
        let char = Warrior()
        let enemy = GoblinSpear()
        PlayerDatabase.main.party.units.append(char)
        
        battleEngine.enemyTeam.append(enemy)
        
        battleEngine.startBattleInitiatives()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = battleEngine.currentUnit {
            
        }
        battleEngine.currentUnit = nil
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        battleEngine.update(dt: currentTime)
    }
    
}
