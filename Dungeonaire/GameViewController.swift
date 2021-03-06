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
    
    var skView: SKView {
        return view as! SKView
    }
    var scene: GameScene? {
        return skView.scene as? GameScene
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let char1 = Warrior()
        let char2 = Warrior()
        let char3 = Warrior()
        let char4 = Warrior()
        
        UserDatabase.main.party.append(char1)
        UserDatabase.main.party.append(char2)
        UserDatabase.main.party.append(char3)
        UserDatabase.main.party.append(char4)
        
        if skView.scene == nil {
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                skView.presentScene(scene)
                

            }
        }
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
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



