//
//  GameViewController.swift
//  Dungeonaire
//
//  Created by Benjamin Su on 6/1/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var hud: BattleHUDLayer!
    var component = BattleStoredComponents()
    var playerUnits: [Unit] = [Unit]()
    var enemyUnits: [Unit] = [Unit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud = BattleHUDLayer(frame: self.view.frame)
        hud.delegate = self
        view.addSubview(hud)
        
        let char1 = Warrior()
        let char2 = Warrior()
        let enemy1 = GoblinSpear()
        let enemy2 = GoblinSpear()
        UserDatabase.main.party.units.append(char1)
        UserDatabase.main.party.units.append(char2)
        
        playerUnits = UserDatabase.main.party.units
        generateEnemies(array: [enemy1, enemy2])
        
        
        startBattle()
        prepareTurn()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: BattleHUDDelegate {
    func activatedSkill(_ slot: SkillSlot, at target: Int) {
        
        completeTurn(skill: slot, target: target)
        
    }
}

extension GameViewController: BattleStation {
    
    func showDrawn(_ cards: Hand, isPlayer: Bool) {
        
        //set hud to reflect which team to zoom in to
        if isPlayer {
            
        }
        
        //hud shows cards
        hud.label1.text = "\(cards.0.isFriendly)"
        
        
    }
    
    func turnComplete() {
        
        //graphically reset turn
        
        prepareTurn()
        
    }
    
}
