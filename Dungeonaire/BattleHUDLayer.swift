//
//  BattleHUDLayer.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/5/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

enum HUDBattleState {
    
    case player, enemy, neutral
    
}

protocol BattleHUDDelegate: class {
    func activatedSkill(_ slot: SkillSlot, at target: Int)
    
}

class BattleHUDLayer: UIView {
    
    weak var delegate: BattleHUDDelegate?
    var state: HUDBattleState = .neutral
    
    @IBOutlet weak var label1: UILabel!
    @IBAction func skill1(_ sender: Any) {
        if state == .player {
            delegate?.activatedSkill(.first, at: 0)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func update(health: ([Int], [Int])) {
        label1.text = "\(health.0[0])"
    }
    
    

    
    func show(_ cards: Hand) {
        print("showing three cards!")
    }
    
    func endTurn(completion: @escaping () -> ()) {
        
        state = .neutral
        
        completion()
    }
    
    
    
    
    
    
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        
        // Show the view.
        addSubview(view)
    }
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }

}
