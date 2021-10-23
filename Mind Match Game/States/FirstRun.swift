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
    var firstRun: FirstRunHud
    
    init(scene: GameScene) {
        self.scene = scene
        firstRun = FirstRunHud(size: CGSize(width: scene.size.width * 0.90, height: scene.size.height * 0.40))
        firstRun.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        super.init()
        firstRun.firstRunHudButton.delegate = self
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MenuState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        print("First Run State")
        

        self.scene?.addChild(firstRun)
        
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
