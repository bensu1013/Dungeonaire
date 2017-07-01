//
//  StatusEffectFactory.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 7/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct StatusEffectFactory {
    
    static func create(word: String, rank: Int) -> StatusEffect? {
        if let statusType = StatusType(rawValue: word) {
            switch statusType {
            case .Regen:
                return RegenEffect(rank: rank, duration: 2)
            case .Stun:
                return StunEffect(rank: rank, duration: 1)
            default:
                print("StatusType not found in switch case")
                return nil
            }
        } else {
            print("StatusType Not Found")
            return nil
        }
    }
    
    
}
