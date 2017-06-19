//
//  PlayerPartyNode.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/15/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class PartyNode: SKNode {
    
    var offPosition = CGPoint()
    var onPosition = CGPoint(x: 180.0, y: 0.0)
    var party = [SpriteComponent]()
    var partyPos = [CGPoint]()
    var healthNodes = [HealthNode]()
    
    func setVariables(_ node: SKNode) {
        for count in 1...4 {
            if let posNode = node.childNode(withName: "Position\(count)") {
                partyPos.append(posNode.position)
            }
            if let healthNode = node.childNode(withName: "HealthNode\(count)") as? HealthNode {
                healthNode.setVariables(healthNode)
                healthNodes.append(healthNode)
            }
        }
        offPosition = node.position
        if offPosition.x < 0 {
            onPosition.x = -180.0
        }
    }
    
    func updateHealth(_ healths: [Int]) {
        for x in 0...healths.count - 1 {
            healthNodes[x].healthText.text = "\(healths[x])"
        }
    }
    
    func fillParty(with units: [Unit]) {
        
        for (ind, unit) in units.enumerated() {
            let sprite = unit.sprite
            party.append(sprite)
            sprite.isUserInteractionEnabled = true
            sprite.position = partyPos[ind]
            sprite.runAnimation()
            self.addChild(sprite)
            healthNodes[ind].position = partyPos[ind]
            healthNodes[ind].position.y += sprite.frame.height
            healthNodes[ind].healthText.text = "\(unit.battle.health)"
        }
        
    }
    
    func enterSceneAnimation(completion: @escaping () -> () ) {
        let move = SKAction.move(to: onPosition, duration: 1.5)
        run(move) { 
            completion()
        }
    }
    
    func resetParty() {
        for unit in party {
            unit.removeFromParent()
        }
        party.removeAll()
        self.position = offPosition
    }
    
}



