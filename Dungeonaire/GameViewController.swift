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
    let battleEngine = BattleEngine()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //need to connect hud with battleengine
        hud = BattleHUDLayer(frame: self.view.frame)
        hud.delegate = self
        view.addSubview(hud)
        
        let char1 = Warrior()
        let char2 = Warrior()
        let enemy1 = GoblinSpear()
        let enemy2 = GoblinSpear()
        UserDatabase.main.party.units.append(char1)
        UserDatabase.main.party.units.append(char2)
        
        battleEngine.load(first: UserDatabase.main.party.units, second: [enemy1, enemy2])
        battleEngine.startBattle()
        
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
    func activatedSkill(_ slot: SkillSlot) {
        battleEngine.teamOne.currentUnit?.skills.select(slot)
        battleEngine.teamOne.takeTurn {
            self.battleEngine.prepareTurn()
        }
    }
}
