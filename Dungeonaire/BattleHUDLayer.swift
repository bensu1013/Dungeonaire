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
    
//    func activatedSkill(_ slot: SkillSlot, at target: Int)
    func skillSelected(type: GameSceneState)
    
    
}

//TODO: Touch issues withoverlapping views

class BattleHUDLayer: UIView {
    
    weak var delegate: BattleHUDDelegate?
    var state: HUDBattleState = .neutral
    var handCards: Hand?
    
    @IBOutlet weak var label1: UILabel!
    @IBAction func skill1(_ sender: Any) {
        print("skill")
        if state == .player {
            if handCards![0].isFriendly {
                delegate?.skillSelected(type: .targetEnemy)
            } else {
                delegate?.skillSelected(type: .targetPlayer)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
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
        handCards = cards
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
        view.backgroundColor = UIColor.clear
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
