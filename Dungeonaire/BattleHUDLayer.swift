//
//  BattleHUDLayer.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/5/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

protocol BattleHUDDelegate: class {
    func activatedSkill(_ slot: SkillSlot)
}

class BattleHUDLayer: UIView {
    
    weak var delegate: BattleHUDDelegate?
    weak var battle: BattleEngine?
    @IBOutlet weak var label1: UILabel!
    @IBAction func skill1(_ sender: Any) {
        battle?.teamOne.currentUnit?.skills.select(.first)
        battle?.teamOne.currentUnit?.sprite.state = .attack
        battle?.teamOne.takeTurn {
            self.battle?.prepareTurn()
        }
        label1.text = "\(battle!.teamOne.party[0].health)"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func updateHealth() {
        
    }
    
    func setButtons(_ skills: [Skill]) {
        
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
