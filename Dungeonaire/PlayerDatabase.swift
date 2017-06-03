//
//  PlayerModel.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class PlayerDatabase {
    
    static var main = PlayerDatabase()
    
    private init() {}
    
    var party = PartyMembers()
    var inventory = [Item]()
    var gold = 0
    
    
    
}
