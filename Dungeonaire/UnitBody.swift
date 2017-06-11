//
//  UnitSprite.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/8/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

enum AnimationState: String {
    case idle, attack
}

class UnitBody {
    
    var body = SKSpriteNode(texture: nil, size: CGSize(width: 64.0, height: 64.0))
    var animation: AnimationSprite = ASWarriorIdle()
    var state: AnimationState = .idle {
        willSet {
            print("animating")
            if newValue != state {
                changeState(to: state)
            }
            runAnimation()
        }
    }
    
    func changeState(to state: AnimationState) {
        switch state {
        case .idle:
            animation = ASWarriorIdle()
        case .attack:
            animation = ASWarriorAttack()
        }
    }
    
    func runAnimation() {
        animation.animate(body) { (newState) in
            self.state = newState
        }
    }
    
    func update(dt: TimeInterval) {
        
    }
    
}

class AnimationSprite {
    
    func animate(_ body: SKSpriteNode, completion: @escaping (AnimationState) -> () ) {
        
    }
    
}

class ASWarriorIdle: AnimationSprite {
    
    var texture = [SKTexture]()
    var text: [UIColor] = [.brown, .green, .blue, .gray]
    
    override func animate(_ body: SKSpriteNode, completion: @escaping (AnimationState) -> ()) {
        body.removeAllActions()
        var sequence = [SKAction]()
//        let animation = SKAction.animate(with: texture, timePerFrame: 0.2)
        for color in text {
            let ani = SKAction.run {
                body.color = color
            }
            sequence.append(ani)
            let wait = SKAction.wait(forDuration: 0.2)
            sequence.append(wait)
        }
        let complete = SKAction.run {
            completion(.idle)
        }
        sequence.append(complete)
        body.run(SKAction.sequence(sequence))
    }
    
}

class ASWarriorAttack: AnimationSprite {
    
    var texture = [SKTexture]()
    
    override func animate(_ body: SKSpriteNode, completion: @escaping (AnimationState) -> ()) {
        body.removeAllActions()
        let animation = SKAction.animate(with: texture, timePerFrame: 0.2)
        let complete = SKAction.run {
            completion(.idle)
        }
        body.run(SKAction.sequence([animation, complete]))
    }
}




