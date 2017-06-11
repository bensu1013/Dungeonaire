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
    
    var frameTime: Double = 0
    
    override func didMove(to view: SKView) {
        var meh: CGFloat = -50
        for unit in UserDatabase.main.party.units {
            unit.body.body.position.x = meh
            unit.body.runAnimation()
            self.addChild(unit.body.body)
            meh += 50
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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
