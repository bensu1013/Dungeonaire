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
    }
    
    func fillParty(with units: [Unit]) {
        
        for (ind, unit) in units.enumerated() {
            let sprite = unit.sprite
            party.append(sprite)
            sprite.body.position = partyPos[ind]
            sprite.runAnimation()
            self.addChild(sprite.body)
            healthNodes[ind].position = partyPos[ind]
            healthNodes[ind].position.y += sprite.body.frame.height
        }
        
    }
    
}
