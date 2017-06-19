//
//  ExploreGameState.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/16/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import GameplayKit

enum ExploreState {
    case neutral, left, right
}

class ExploreGameState: GKState {
    var scene: GameScene!
    var exploreState: ExploreState = .neutral
    var battleTriggers = [SKNode]()
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == BattleGameState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        battleTriggers.removeAll()
        if let trigger = scene!.childNode(withName: "BattleTrigger") {
            battleTriggers.append(trigger)
        }
        
        for sprite in scene.playerPartyNode.party {
            sprite.onPressed = unitPressed(_:)
        }
        
        scene!.isUserInteractionEnabled = false
        scene!.playerPartyNode.enterSceneAnimation {
            self.scene.isUserInteractionEnabled = true
        }
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        if exploreState == .left {
            scene.camera!.position.x -= 2.0
            scene.unitsNode.position.x -= 2.0
        } else if exploreState == .right {
            scene.camera!.position.x += 2.0
            scene.unitsNode.position.x += 2.0
        }
        //TODO: remove triggers
        for trigger in battleTriggers {
            if (scene.camera?.contains(trigger))! {
                trigger.removeFromParent()
                enterBattle()
            }
        }
    }
    
    func enterBattle() {
        endMovement()
        stateMachine?.enter(BattleGameState.self)
    }
    
    func unitPressed(_ unit: Unit) {
        print("exploring with \(unit)")
        
        
    }
    
    func input(for touch: UITouch) {
        triggerMovement(touch: touch)
    }
    
    func triggerMovement(touch: UITouch) {
        if touch.location(in: scene!.cardsPlayingNode).x <  -(scene!.frame.width / 4) {
            exploreState = .left
        } else if touch.location(in: scene!.cardsPlayingNode).x > scene!.frame.width / 4 {
            exploreState = .right
        }
    }
    
    func endMovement() {
        exploreState = .neutral
    }
    
}
