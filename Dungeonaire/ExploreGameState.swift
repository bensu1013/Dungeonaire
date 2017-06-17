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
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == BattleGameState.self
    }
    
    override func didEnter(from previousState: GKState?) {
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
        if (scene.camera?.contains(scene!.childNode(withName: "BattleTrigger")!))! {
            enterBattle()
        }
    }
    
    func enterBattle() {
        stateMachine?.enter(BattleGameState.self)
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
