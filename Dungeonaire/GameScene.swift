//
//  GameScene.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import SpriteKit
import GameplayKit

enum CameraState {
    case neutral
    case playerTeam
    case enemyTeam
    case reverseTeam
}

class GameScene: SKScene {
    
    var stateMachine: GKStateMachine?
    
    //TODO: - Need a way to handle AI graphics
    var frameTime: Double = 0
    var cardsPlayingNode: CardPlayingNode!
    var unitsNode: SKNode!
    var playerPartyNode: PartyNode!
    var enemyPartyNode: PartyNode!
    
    
    override func didMove(to view: SKView) {
        
        let cam = SKCameraNode()
        camera = cam
        addChild(cam)
        
        if let unitsNode = childNode(withName: "UnitsNode") {
            self.unitsNode = unitsNode
            if let partyNode = unitsNode.childNode(withName: "PlayerPartyNode") as? PartyNode {
                playerPartyNode = partyNode
                playerPartyNode.setVariables(partyNode)
            }
            if let partyNode = unitsNode.childNode(withName: "EnemyPartyNode") as? PartyNode {
                enemyPartyNode = partyNode
                enemyPartyNode.setVariables(partyNode)
            }
        }
        playerPartyNode.fillParty(with: UserDatabase.main.party.units)
        if let cardsNode = childNode(withName: "CardPlayingNode") as? CardPlayingNode {
            cardsPlayingNode = cardsNode
            cardsPlayingNode.setVariables(cardsNode)
        }
        if let menu = childNode(withName: "MenuButton") as? SKSpriteNode {
            menu.removeFromParent()
            camera?.addChild(menu)
        }
        cardsPlayingNode.removeFromParent()
        camera?.addChild(cardsPlayingNode)
        
        let battleGameState = BattleGameState(scene: self)
        let exploreGameState = ExploreGameState(scene: self)
        
        stateMachine = GKStateMachine(states: [battleGameState, exploreGameState])
        stateMachine?.enter(ExploreGameState.self)
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        stateMachine?.update(deltaTime: currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let currentState = stateMachine!.currentState as? ExploreGameState {
            currentState.input(for: touches.first!)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let currentState = stateMachine!.currentState as? ExploreGameState {
            currentState.endMovement()
        }
    }
    
    func zoom(to team: Team, completion: @escaping () -> () ) {
        zoom(to: getPosition(for: team)) { 
            completion()
        }
    }
    
    func getPosition(for team: Team) -> CGPoint {
        if team == .team1 {
            return CGPoint(x: unitsNode.position.x - playerPartyNode.position.x, y: 0.0)
        } else {
            return CGPoint(x: unitsNode.position.x - enemyPartyNode.position.x, y: 0.0)
        }
    }
    
    func zoom(to pos: CGPoint, completion: @escaping () ->() ) {
        let move = SKAction.move(to: pos, duration: 0.5)
        camera?.run(move)
        let scale = SKAction.scale(to: 0.8, duration: 0.5)
        camera?.run(scale, completion: { 
            self.isUserInteractionEnabled = true
            completion()
        })
    }
    
    func unZoom(to pos: CGPoint, completion: @escaping () -> () ) {
        let move = SKAction.move(to: pos, duration: 0.5)
        camera?.run(move)
        let scale = SKAction.scale(to: 1.0, duration: 0.5)
        camera?.run(scale, completion: {
            self.isUserInteractionEnabled = true
            completion()
        })
    }
    
}






