//
//  GameScene.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import SpriteKit
import GameplayKit

enum GameSceneState {
    
    case movement
    case battle
    case targetPlayer
    case targetEnemy
    
    
}


class GameScene: SKScene {
    
    var frameTime: Double = 0
    var state: GameSceneState = .movement
    
    var cardsNode = CardPlayingNode()
    
    
    //should contain array of sprite bodies relevant for input
    var playerSprites = [SpriteComponent]()
    
    override func didMove(to view: SKView) {
        var meh: CGFloat = -50
        for unit in UserDatabase.main.party.units {
            playerSprites.append(unit.sprite)
            unit.sprite.body.position.x = meh
            unit.sprite.runAnimation()
            self.addChild(unit.sprite.body)
            meh += 100
        }
        
        if let cardPlayingNode = camera?.childNode(withName: "CardPlayingNode") {
            print("cardNode")
            cardsNode.setVariables(cardPlayingNode)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("start touching me")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            print("touch")
            for sprite in playerSprites {
                if sprite.body.contains(touch.location(in: self)) {
                    print("woah")
                }
            }
            
        }
    }
    
    
    func zoom() {
        camera?.position = CGPoint(x: -50, y: 0)
        camera?.setScale(0.8)
    }
    
    func unZoom() {
        camera?.position = CGPoint(x: 100, y: 0)
        camera?.setScale(1.5)
    }
    
    
}

extension GameScene: BattleHUDDelegate {
    func skillSelected(type: GameSceneState) {
        self.state = type
    }
}




