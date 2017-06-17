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
    var inputState: InputState = .neutral {
        didSet {
            takeAITurn()
        }
    }
    var currentTeam: Team = .team1 {
        willSet {
            if newValue == .team2 {
                useAIChoices = aiCalc()
            }
        }
    }
    var useAIChoices: (SkillCard, Int)?
    var selectedCard: SkillCard?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
        playerUnits = UserDatabase.main.party.units
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == ExploreGameState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        let enemy1 = GoblinSpear()
        let enemy2 = GoblinSpear()
        let enemy3 = GoblinSpear()
        let enemy4 = GoblinSpear()
        enemyUnits = [enemy1, enemy2, enemy3, enemy4]
        scene.enemyPartyNode.fillParty(with: [enemy1, enemy2, enemy3, enemy4])
        scene.enemyPartyNode.enterSceneAnimation {
           
            self.startBattle()
            self.startTurn()
            
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        checkForWinner()
    }
    
    func startTurn() {
        self.prepareTurn(completion: { (team) in
            let hand = self.drawCards()
            self.currentTeam = team
            self.scene.cardsPlayingNode.showCards(with: hand, for: team, selector: self.cardPressed)
            self.inputState = .card
        })
    }
    
    func takeAITurn() {
        guard let aiChoice = useAIChoices else { return }
        scene.isUserInteractionEnabled = false
        if inputState == .card {
            cardPressed(aiChoice.0)
        } else if inputState == .target {
            unZoom {
                //attack animation
                self.completeTurn(card: aiChoice.0, target: aiChoice.1)
                self.inputState = .neutral
                self.startTurn()
            }
        } else {
            scene.cardsPlayingNode.clearCards()
            useAIChoices = nil
        }
    }
    
    func cardPressed(_ card: SkillCard) {
        selectedCard = card
        if card.isFriendly {
            moveCamera(to: currentTeam.getOpposite(), completion: {
                self.inputState = .target
            })
        } else {
            moveCamera(to: currentTeam, completion: {
                self.inputState = .target
            })
        }
        
    }
    
    func endBattle() {
        stateMachine?.enter(ExploreGameState.self)
    }
    
    func checkForWinner() {
        if let winner = wonBattle() {
            if winner == .team1 {
                print("victory")
                endBattle()
            } else {
                print("defeat")
                
            }
        }
    }
    
    func moveCamera(to team: Team, completion: @escaping () -> () ) {
        zoom(to: getPosition(for: team)) {
            completion()
        }
    }
    
    func getPosition(for team: Team) -> CGPoint {
        if team == .team1 {
            return CGPoint(x: scene.unitsNode.position.x - scene.playerPartyNode.position.x, y: 0.0)
        } else {
            return CGPoint(x: scene.unitsNode.position.x - scene.enemyPartyNode.position.x, y: 0.0)
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





