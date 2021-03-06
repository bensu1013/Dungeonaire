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


class SpriteComponent: SKSpriteNode {
    
    var unit: Unit!
    var animation: AnimationSprite = ASWarriorIdle()
    var onPressed: ((Unit) -> ())?
    var state: AnimationState = .idle {
        willSet {
            if newValue != state {
                changeState(to: newValue)
            }
        }
        didSet {
            runAnimation()
        }
    }
    
    init() {
        super.init(texture: nil, color: .black, size: CGSize(width: 60.0, height: 100.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let press = onPressed {
                press(unit)
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
        animation.animate(self) { (newState) in
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
    var text: [UIColor] = [.brown, .green, .brown, .green]
    
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
    var text: [UIColor] = [.lightGray, .cyan, .lightGray, .cyan]
    
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




