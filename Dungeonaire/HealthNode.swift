//
//  HealthNode.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/15/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import SpriteKit

class HealthNode: SKNode {
    
    var healthBar = SKSpriteNode()
    var healthText = SKLabelNode()
    
    func setVariables(_ node: SKNode) {
        
        if let bar = node.childNode(withName: "HealthBar") as? SKSpriteNode {
            healthBar = bar
        }
        if let name = node.childNode(withName: "UnitName") as? SKLabelNode {
            healthText = name
        }
        
    }
    
}
