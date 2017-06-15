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
    var scene: GameScene?
    
    var playerUnits: [Unit] = [Unit]()
    var enemyUnits: [Unit] = [Unit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = SKView(frame: view.frame)
        view.addSubview(skView)
        
        hud = BattleHUDLayer(frame: self.view.frame)
        
        view.addSubview(hud)
        
        let char1 = Warrior()
        let char2 = Warrior()
        let enemy1 = GoblinSpear()
        let enemy2 = GoblinSpear()
        UserDatabase.main.party.units.append(char1)
        UserDatabase.main.party.units.append(char2)
        
        playerUnits = UserDatabase.main.party.units
        generateEnemies(array: [enemy1, enemy2])
        
        
        
        
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            self.scene = scene
            hud.delegate = scene
            // Present the scene
            skView.presentScene(scene)
            
            
        }
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        
        startBattle()
        prepareTurn()
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

//extension GameViewController: BattleHUDDelegate {
//    
//    
//    
//}

extension GameViewController: BattleStation {
    
    func showDrawn(_ cards: Hand, isPlayer: Bool) {
        
        //set scene to reflect which team to zoom in to
        if isPlayer {
            //scene.zoom
            hud.state = .player
            scene?.state = .battle
            scene?.zoom()
        } else {
            
            hud.state = .enemy
            scene?.state = .battle
            
        }
        
        //hud shows cards
        hud.show(cards)
        
    }
    
    func showEndTurn() {
        
        //graphically reset turn
        scene?.unZoom()
        hud.endTurn {
            self.prepareTurn()
        }
        
        
    }
    
    func updateHUD(health: ([Int], [Int])) {
        hud.update(health: health)
    }
    
}
