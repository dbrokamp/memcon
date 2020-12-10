//
//  FirstRun.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 12/8/20.
//  Copyright © 2020 Drew Brokamp. All rights reserved.
//

import GameplayKit

class FirstRun: GKState, ButtonProtocol {

    private weak var scene: GameScene?
    
    init(scene: GameScene) {
        self.scene = scene
        
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MenuState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        print("First Run State")
        
        scene?.firstRun.firstRunHudButton.delegate = self
        scene?.addChild((scene?.firstRun!)!)
        
    }
    
    func buttonPressed(sender: Button) {
        if sender.name == "firstRunHudButton" {
            if scene?.firstRun.slide == Slides.first {
                scene?.firstRun.changeSlide(toSlide: .second)
            } else if scene?.firstRun.slide == Slides.second {
                scene?.firstRun.changeSlide(toSlide: .third)
            } else if scene?.firstRun.slide == Slides.third {
                scene?.firstRun.changeSlide(toSlide: .fourth)
            } else if scene?.firstRun.slide == Slides.fourth {
                scene?.firstRun.changeSlide(toSlide: .complete)
                scene?.stateMachine?.enter(MenuState.self)
                
            }
            //                self.gameManager.firstRun = true
        } else {
            print("No button pressed")
        }
    }
    
    override func willExit(to nextState: GKState) {
        scene?.firstRun.run(SKAction.fadeAlpha(to: 0.0, duration: 0.5))
        scene?.firstRun.removeAllActions()
        scene?.firstRun.removeAllChildren()
        scene?.firstRun.removeFromParent()
        scene?.gameManager.firstRun = true
    }
    
    
    
}
