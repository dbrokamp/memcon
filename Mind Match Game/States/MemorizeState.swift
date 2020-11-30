//
//  NewGameMemorizeState.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//
/*
 1.
 */

import GameplayKit

class MemorizeState: GKState {
    
    private var scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MatchState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        print("MemorizeState")
        
        // Wait a beat then enter the memorize countdown
        scene.run(SKAction.wait(forDuration: 1.0)) {
            self.memorizeCountDown()
        }
        
        
    }
    
    override func willExit(to nextState: GKState) {
        // Save the game
        scene.gameManager.saveGame()
    }
    
    func memorizeCountDown() {
        var timer = scene.gameManager.memorize
        scene.topHUD.barTimer.removeFromParent()
        scene.topHUD.setupBarTimer(barColor: .auroraGreen, actionLabelText: "Memorize: \(timer)")
        
        self.scene.cardManager.flipCardsFaceUp()
        

        let turnYellow = Double(timer) * 0.50
        let turnRed = Double(timer) * 0.25
        
        let wait = SKAction.wait(forDuration: 1.0)
        
        let block = SKAction.run {
            [unowned self] in
            
            if timer > 0  {
                timer -= 1
                if timer <= Int(turnYellow) {
                    self.scene.topHUD.barTimer.changeTimerBarColor(newColor: .squashBlossom)
                }
                
                if timer <= Int(turnRed) {
                    self.scene.topHUD.barTimer.changeTimerBarColor(newColor: .mandarinRed)
                }
                
                scene.topHUD.barTimer.decreaseTimerBar(currentWidth: self.scene.topHUD.barTimer.size.width,
                                                hudDecreaseBy: self.scene.topHUD.barTimer.size.width / CGFloat(timer),
                                                decreaseDuration: 1.0)
                scene.topHUD.barTimer.changeActionLabel(newText: "Memorize: \(timer)")
                
            } else {
                self.scene.removeAction(forKey: "countdown")
                self.scene.topHUD.barTimer.removeFromParent()
                self.scene.stateMachine?.enter(MatchState.self)
            }
        }
        
        let sequence = SKAction.sequence([wait,block])
        
        self.scene.run(SKAction.repeatForever(sequence), withKey: "countdown")
        
    }
    
    
}
