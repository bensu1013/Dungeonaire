//
//  Aliases.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/8/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

//tuple for a hand of newly drawn cards
typealias Hand = [SkillCard]

//tuple wrapping for targets and associated damage
typealias TargetedDamage = (Int, Double)

//initiative threshold for next turn
var turnThreshold = 100
