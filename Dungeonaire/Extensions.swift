//
//  Extensions.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/8/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

extension Double {
    
    //returns a smaller number between the percentage given and 100%
    func modify(by percent: Double = 30.0) -> Double {
        var range = percent
        if range < 0 {
            range = 0
        } else if range > 100 {
            range = 100
        }
        let base = 100.0 - range
        let rand = Double(arc4random_uniform(UInt32(range))) + base
        return self * rand / 100.0
    }
    
}
