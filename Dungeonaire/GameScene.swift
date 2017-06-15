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

enum InputState {
    
    case neutral
    case cards
    case targets
    
}

class GameScene: SKScene {
    
    var frameTime: Double = 0
    var state: GameSceneState = .movement
    
    var cardsPlayingNode = CardPlayingNode()
    
    //create a party and enemy node controller similar to cardplayingnode
    var playerPartyNode = PartyNode()
    var enemyPartyNode = PartyNode()
    
    //should contain array of sprite bodies relevant for input
    var playerSprites = [SpriteComponent]()
    
    
    override func didMove(to view: SKView) {
    
        if let partyNode = childNode(withName: "PlayerPartyNode") as? PartyNode {
            playerPartyNode = partyNode
            playerPartyNode.setVariables(partyNode)
        }
        
        if let partyNode = childNode(withName: "EnemyPartyNode") as? PartyNode {
            enemyPartyNode = partyNode
            enemyPartyNode.setVariables(partyNode)
        }
        
        playerPartyNode.fillParty(with: UserDatabase.main.party.units)
        
        if let cardsNode = camera?.childNode(withName: "CardPlayingNode") as? CardPlayingNode {
            cardsPlayingNode = cardsNode
            cardsPlayingNode.setVariables(cardsNode)
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
        cardsPlayingNode.showCards()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            for sprite in playerSprites {
                if sprite.body.contains(touch.location(in: self)) {
                    
                }
            }
        }
        cardsPlayingNode.clearCards()
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




