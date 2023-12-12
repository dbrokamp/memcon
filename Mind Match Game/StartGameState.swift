//
//  StartGameState.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 10/27/20.
//  Copyright © 2020 Drew Brokamp. All rights reserved.
//
//
//

import SpriteKit
import GameplayKit

class MenuState: GKState, ButtonProtocol {
    
    var scene: GameSceneNew
    var cover: SKSpriteNode
    var startGame: Button
    
    init(scene: GameSceneNew) {
        self.scene = scene
        self.cover = SKSpriteNode()
        startGame = Button(text: "Start Game", textSize: 20, defaultColor: .white, pressedColor: .gray)
    }
    
    override func didEnter(from previousState: GKState?) {
        //MARK: Debug
        print("Entered StartGameState")
        
        // Setup Transparent Cover over playing table
        cover = SKSpriteNode(color: .black, size: scene.view!.frame.size)
        cover.position = CGPoint(x: scene.view!.frame.midX, y: scene.view!.frame.midY)
        cover.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        cover.zPosition = ZPositions.overviews
        cover.alpha = 0.80
        scene.addChild(cover)
        
        // Add StartGame Button
        startGame.delegate = self
        startGame.position = CGPoint(x: scene.view!.frame.midX, y: scene.view!.frame.midY)
        startGame.name = "Start Game"
        startGame.fontName = "SFPro-Regular"
        scene.addChild(startGame)
        
    }
    
    public func buttonPressed(sender: Button) {
        if sender.name == "Start Game" {
            self.stateMachine?.enter(MemorizeState.self)
        }
        
        scene.run(SKAction.wait(forDuration: 0.5)) {
            self.startGame.removeFromParent()
        }

        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        return stateClass == MemorizeState.self
        
    }
    
    override func willExit(to nextState: GKState) {
        cover.run(SKAction.fadeOut(withDuration: 1.0))
        scene.run(SKAction.wait(forDuration: 1.0)) {
            self.cover.removeFromParent()
        }
        
    }
    
}
