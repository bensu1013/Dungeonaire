//
//  PlayerModel.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class UserDatabase {
    
    static var main = UserDatabase()
    
    private init() {}
    
    var party = [PlayerUnit]()
    var inventory = [Item]()
    var gold = 0
    
    
    
}
