//
//  GameSceneState.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/16/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import GameplayKit

enum InputState {
    case neutral
    case card
    case target
}


class BattleGameState: GKState, BattleStation {
    
    var scene: GameScene!
    
    var component: BattleStoredComponents = BattleStoredComponents()
    var inputState: InputState = .neutral
    var currentTeam: Team = .team1 {
        willSet {
            if newValue == .team2 {
                takeAITurn()
            }
        }
    }
    var selectedCard: SkillCard?
    var selectedTarget: Unit?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
        playerUnits = UserDatabase.main.party.units
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == ExploreGameState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        
        for card in scene.cardsPlayingNode.cards {
            card.onPressed = cardPressed(_:)
        }
        for sprite in scene.playerPartyNode.party {
            sprite.onPressed = unitPressed(_:)
        }
        
        let enemy1 = GoblinSpear()
        let enemy2 = GoblinSpear()
        let enemy3 = GoblinSpear()
        let enemy4 = GoblinSpear()
        enemyUnits = [enemy1, enemy2, enemy3, enemy4]
        scene.enemyPartyNode.fillParty(with: [enemy1, enemy2, enemy3, enemy4])
        for sprite in scene.enemyPartyNode.party {
            sprite.onPressed = unitPressed(_:)
        }
        scene.enemyPartyNode.enterSceneAnimation {
            self.startBattle()
            self.startTurn()
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    func startTurn() {
        self.prepareTurn(completion: { (team) in
            let hand = self.drawCards()
            self.currentTeam = team
            self.scene.cardsPlayingNode.showCards(with: hand, for: team)
            self.inputState = .card
        })
    }
    
    func takeAITurn() {
        let aiChoice = aiCalc()
        scene.isUserInteractionEnabled = false
        let delay = SKAction.wait(forDuration: 1.0)
        let card = SKAction.run {
            self.cardPressed(aiChoice.0)
        }
        let target = SKAction.run {
            self.unitPressed(aiChoice.1)
        }
        let aiSequence = SKAction.sequence([delay, card, delay, target])
        scene.run(aiSequence) { 
            self.scene.isUserInteractionEnabled = true
        }
    }
    
    func cardPressed(_ card: SkillCard) {
        if inputState == .card {
            selectedCard = card
            if card.targetEnemy {
                for sprite in scene.playerPartyNode.party {
                    sprite.isUserInteractionEnabled = false
                }
                moveCamera(to: currentTeam.getOpposite(), completion: {
                    self.inputState = .target
                })
            } else {
                for sprite in scene.enemyPartyNode.party {
                    sprite.isUserInteractionEnabled = false
                }
                moveCamera(to: currentTeam, completion: {
                    self.inputState = .target
                })
            }
        }
    }
    
    func unitPressed(_ unit: Unit) {
        if inputState == .target {
            selectedTarget = unit
            scene.cardsPlayingNode.clearCards()
            unZoom {
                for sprite in self.scene.playerPartyNode.party {
                    sprite.isUserInteractionEnabled = true
                }
                for sprite in self.scene.enemyPartyNode.party {
                    sprite.isUserInteractionEnabled = true
                }
                if self.selectedCard!.multiTarget {
                    self.completeTurn(card: self.selectedCard!, targets: self.enemyUnits)
                } else {
                    self.completeTurn(card: self.selectedCard!, targets: [self.selectedTarget!])
                }
                self.updateHealthNodes()
                self.inputState = .neutral
                self.checkForWinner()
            }
        }
    }
    
    func updateHealthNodes() {
        let newHealths = unitsHealth()
        scene.playerPartyNode.updateHealth(newHealths.0)
        scene.enemyPartyNode.updateHealth(newHealths.1)
    }
    
    func endBattle() {
        unZoom {
            self.stateMachine?.enter(ExploreGameState.self)
        }
    }
    
    func checkForWinner() {
        if let winner = wonBattle() {
            if winner == .team1 {
                print("victory")
                scene!.enemyPartyNode.resetParty()
                endBattle()
            } else {
                print("defeat")
                //game over , leave game scene
            }
        } else {
            self.startTurn()
        }
    }
    
    func moveCamera(to team: Team, completion: @escaping () -> () ) {
        zoom(to: getPosition(for: team)) {
            completion()
        }
    }
    
    func getPosition(for team: Team) -> CGPoint {
        if team == .team1 {
            return CGPoint(x: scene.unitsNode.position.x + scene.playerPartyNode.position.x, y: 0.0)
        } else {
            return CGPoint(x: scene.unitsNode.position.x + scene.enemyPartyNode.position.x, y: 0.0)
        }
    }
    
    func zoom(to pos: CGPoint, completion: @escaping () ->() ) {
        self.scene.isUserInteractionEnabled = false
        let move = SKAction.move(to: pos, duration: 0.5)
        scene.camera?.run(move)
        let scale = SKAction.scale(to: 0.8, duration: 0.5)
        scene.camera?.run(scale, completion: {
            self.scene.isUserInteractionEnabled = true
            completion()
        })
    }
    
    func unZoom(completion: @escaping () -> () ) {
        self.scene.isUserInteractionEnabled = false
        let pos = scene.unitsNode.position
        let move = SKAction.move(to: pos, duration: 0.5)
        scene.camera?.run(move)
        let scale = SKAction.scale(to: 1.0, duration: 0.5)
        scene.camera?.run(scale, completion: {
            self.scene.isUserInteractionEnabled = true
            completion()
        })
    }
    
}





