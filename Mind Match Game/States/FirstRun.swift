//
//  FirstRun.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 12/8/20.
//  Copyright © 2020 Drew Brokamp. All rights reserved.
//
//  ----------------------------------------------------------------------------------------------
//
//
//  The stateMachine will enter this only if gameManager.firstRun == false
//      - Moves through 4 slides describing the rules of the game and point system
//
//  Exits to the MenuState
//
//
//  ----------------------------------------------------------------------------------------------


import GameplayKit

class FirstRun: GKState, ButtonProtocol {

    private weak var scene: GameScene?
    private var firstRun: FirstRunHud
    
    init(scene: GameScene) {
        self.scene = scene
        firstRun = FirstRunHud(size: CGSize(width: scene.size.width * 0.90, height: scene.size.height * 0.40))
        firstRun.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        super.init()
        firstRun.firstRunHudButton.delegate = self
    }
    
    
    // This state can only exit to the MenuState
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MenuState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        print("First Run State")
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        scene.addChild(firstRun)
        
    }
    
    func buttonPressed(sender: Button) {
        if sender.name == "firstRunHudButton" {
            if firstRun.slide == Slides.first {
                firstRun.changeSlide(toSlide: .second)
            } else if firstRun.slide == Slides.second {
                firstRun.changeSlide(toSlide: .third)
            } else if firstRun.slide == Slides.third {
                firstRun.changeSlide(toSlide: .fourth)
            } else if firstRun.slide == Slides.fourth {
                firstRun.changeSlide(toSlide: .complete)
                scene?.stateMachine.enter(MenuState.self)
                
            }
            //                self.gameManager.firstRun = true
        } else {
            print("No button pressed")
        }
    }
    
    override func willExit(to nextState: GKState) {
        firstRun.run(SKAction.fadeAlpha(to: 0.0, duration: 0.5))
        firstRun.removeAllActions()
        firstRun.removeAllChildren()
        firstRun.removeFromParent()
        scene?.gameManager.firstRun = true
    }
    
   
}
