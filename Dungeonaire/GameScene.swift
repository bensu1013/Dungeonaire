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
        
        battleEngine.startBattleInitiatives()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let unit = battleEngine.currentUnit as? PlayerUnit {
            unit.selectSkill(0)
            battleEngine.playerTurn()
        }
        battleEngine.currentUnit = nil
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        battleEngine.update(dt: currentTime)
    }
    
}
