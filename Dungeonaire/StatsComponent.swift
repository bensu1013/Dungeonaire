//
//  stats.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/2/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct StatsComponent {
    
    var strength = 0
    var dexterity = 0
    var vitality = 0
    var wisdom = 0
    var luck = 0
    var physicalModifier: Int {
        get {
            return strength / 2 + dexterity / 4
        }
    }
    var magicalModifier: Int {
        get {
            return wisdom / 2 + luck / 4
        }
    }
    var dodgeModifier: Int {
        get {
            return (dexterity * 2) + luck
        }
    }
    var resistModifier: Int {
        get {
            return vitality * 2 + wisdom + strength
        }
    }
    var physicalAccuraryModifier: Int {
        get {
            return dexterity * 2 + luck + 60
        }
    }
    var magicalAccuracyModifier: Int {
        get {
            return wisdom * 2 + luck + 60
        }
    }
}




