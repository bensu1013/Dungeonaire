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
    case playerTeam
    case enemyTeam
    case reverseTeam
    
}

enum InputState {
    
    case neutral
    case cards
    case targets
    
}

class GameScene: SKScene {
    
    //Need a way to handle AI graphics
    var frameTime: Double = 0
    var state: GameSceneState = .movement
    var inputState: InputState = .neutral {
        willSet {
            if newValue == .cards &&
                state == .enemyTeam {
                aiCalc()
            }
        }
    }
    var cardsPlayingNode = CardPlayingNode()
    var playerPartyNode = PartyNode()
    var enemyPartyNode = PartyNode()
    
    var playerUnits: [Unit] = UserDatabase.main.party.units
    var enemyUnits: [Unit] = [Unit]()
    var component: BattleStoredComponents = BattleStoredComponents()
    
    override func didMove(to view: SKView) {
        
        let cam = SKCameraNode()
        camera = cam
        addChild(cam)
        
        if let partyNode = childNode(withName: "PlayerPartyNode") as? PartyNode {
            playerPartyNode = partyNode
            playerPartyNode.setVariables(partyNode)
        }
        if let partyNode = childNode(withName: "EnemyPartyNode") as? PartyNode {
            enemyPartyNode = partyNode
            enemyPartyNode.setVariables(partyNode)
        }
        playerPartyNode.fillParty(with: playerUnits)
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
        if let touch = touches.first {
            switch inputState {
            case .cards:
                for (ind, sprite) in cardsPlayingNode.cards.enumerated() {
                    if sprite.contains(touch.location(in: cardsPlayingNode)) {
                        if !sprite.skillCard!.isFriendly {
                            cardsPlayingNode.selectedCard = sprite
                            adjustCamera(to: .reverseTeam) {
                                self.inputState = .targets
                            }
                            
                        }
                    }
                }
            case .targets:
                for (ind, sprite) in playerPartyNode.party.enumerated() {
                    if sprite.body.contains(touch.location(in: playerPartyNode)) {
                        adjustCamera(to: .battle) {
                            self.completeTurn(card: self.cardsPlayingNode.selectedCard!.skillCard! , target: ind)
                            self.inputState = .neutral
                        }
                        break
                    }
                }
                for (ind, sprite) in enemyPartyNode.party.enumerated() {
                    if sprite.body.contains(touch.location(in: enemyPartyNode)) {
                        adjustCamera(to: .battle) {
                            self.completeTurn(card: self.cardsPlayingNode.selectedCard!.skillCard! , target: ind)
                            self.inputState = .neutral
                        }
                        break
                    }
                }
            case .neutral: break
            }
            
        }
    }
    
    func startScene() {
        
        playerPartyNode.enterSceneAnimation {
            
        }
        
    }
    
    func triggerBattle() {
        
        enemyPartyNode.enterSceneAnimation {
            self.startBattle()
            self.prepareTurn {
                self.takeAITurn()
            }
        }
        
    }
    
    func adjustCamera(to state: GameSceneState, completion: @escaping () -> () ) {
        isUserInteractionEnabled = false
        switch state {
        case .playerTeam:
            zoom(to: playerPartyNode.position) {
                completion()
            }
        case .enemyTeam:
            zoom(to: enemyPartyNode.position) {
                completion()
            }
        case .reverseTeam:
            if self.state == .playerTeam {
                zoom(to: enemyPartyNode.position) {
                    completion()
                }
            } else if self.state == .enemyTeam {
                zoom(to: playerPartyNode.position) {
                    completion()
                }
            }
        default:
            unZoom(to: CGPoint.zero) {
                completion()
            }
        }
        self.state = state
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

extension GameScene: BattleStation {
    
    func showDrawn(_ cards: Hand, isPlayer: Bool, completion: @escaping () -> () ) {
        if isPlayer {
            cardsPlayingNode.showCards(with: cards)
            adjustCamera(to: .playerTeam) {
                completion()
            }
        } else {
            cardsPlayingNode.showCards(with: cards)
            adjustCamera(to: .enemyTeam) {
                completion()
            }
        }
        inputState = .cards
    }
    
    func takeAITurn() {
        if self.state == .enemyTeam {
            let aiChoice = self.aiCalc()
            if !aiChoice.0.isFriendly {
                self.adjustCamera(to: .reverseTeam, completion: {
                    self.completeTurn(card: aiChoice.0, target: aiChoice.1)
                })
            }
        }
    }
    
    func updateHUD(health: ([Int], [Int])) {
        for count in 0...health.0.count - 1 {
            playerPartyNode.healthNodes[count].healthText.text = "\(health.0[count])"
        }
        for count in 0...health.1.count - 1 {
            enemyPartyNode.healthNodes[count].healthText.text = "\(health.1[count])"
        }
    }
    
    func showEndTurn(completion: @escaping () -> ()) {
        cardsPlayingNode.clearCards()
        run(SKAction.wait(forDuration: 0.5)) {
            self.prepareTurn {
                self.takeAITurn()
            }
            completion()
        }
    }
    
    
}




