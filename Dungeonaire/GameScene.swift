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
    
    
    
    override func didMove(to view: SKView) {
        let char = Warrior()
        char.equipment.weapon = Weapon()
        
        PlayerDatabase.main.party.append(char)
        
        for s in PlayerDatabase.main.party {
            s.update(dt: 0.0)
        }
        
    }
    
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
}
