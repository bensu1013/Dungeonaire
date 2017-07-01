//
//  StatusEffect.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/30/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

protocol StatusEffect {
    var name: String {get}
    var duration: Int {get}
    var rank: Int {get}
    
    func activateEffect(on target: Unit)
    
}

struct StunEffect: StatusEffect {
    
    var name: String = ""
    var duration: Int = 2
    var rank: Int = 1
    
    func activateEffect(on target: Unit) {
    
    }
    
}
