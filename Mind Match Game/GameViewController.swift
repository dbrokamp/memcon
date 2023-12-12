//
//  GameViewController.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 2/11/19.
//  Copyright © 2019 Drew Brokamp. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit



class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            
            
            // Load the SKScene from 'GameScene.swift'
            let scene = GameScene(size: view.bounds.size)
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.allowsTransparency = true
            view.backgroundColor = .clear
            
            NotificationCenter.default.addObserver(self, selector: #selector(wonGame), name: .wonGame, object: nil)
            
            
        }
        
        GameCenterHelper.helper.viewController = self
        
    }
    
    @objc func wonGame() {
        let alert = UIAlertController(title: "Game Won", message: "Impressive Memory! Resetting game to level 1.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
