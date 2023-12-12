//
//  WonLevelState.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//

import GameplayKit

class WonLevelState: GKState {
    
    var scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    
    override func didEnter(from previousState: GKState?) {
        
        print("WonLevelState")
        
        scene.gameManager.level += 1
        
        scene.resultsHUD.setupResultsTitle(text: "Level Complete")
        scene.resultsHUD.moveMenu(to: .onScreen)
        
        if scene.gameManager.level == 11 {
            NotificationCenter.default.post(name: .wonGame, object: nil)
            scene.gameManager.level = 1 
        }
        
        // Reset timer bar
        scene.topHUD.barTimer.removeFromParent()
        scene.topHUD.setupBarTimer(barColor: .systemGreen, actionLabelText: "Level Completed!")

        // Add all the cards back to the scene
        scene.cardManager.addCardsToCardScene(scene: self.scene)

        // Stack the cards, move the top hud away, enter MenuState
        let block = SKAction.run {
            
            self.scene.run(SKAction.wait(forDuration: 2.0)) {
                self.stackCards()
                self.scene.topHUD.run(SKAction.moveTo(y: self.scene.frame.maxY + self.scene.topHUD.frame.height / 2 , duration: 1.0))
            }
            
            self.scene.run(SKAction.wait(forDuration: 4.0)) {
                self.scene.stateMachine.enter(MenuState.self)
            }
        }
        
        self.scene.run(block)
        
    }
    
    private func stackCards() {
        
        
        var counter = scene.cardManager.cards.count
        
        let wait = SKAction.wait(forDuration: 0.05)
        
        let block = SKAction.run {
            [unowned self] in
            
            if counter > 0  {
                counter -= 1
                self.scene.cardManager.cards[counter].run(SKAction.move(to: CGPoint(x: scene.frame.midX,
                                                                                    y: scene.frame.midY), duration: 0.5))
                
                
            } else {
                scene.removeAction(forKey: "countdown")
            }
        }
        
        let sequence = SKAction.sequence([wait,block])
        
        scene.run(SKAction.repeatForever(sequence), withKey: "countdown")
        
        
    }

    
    override func willExit(to nextState: GKState) {
        // Save the game
        scene.gameManager.saveGame()
        self.scene.cardManager.removeCardsFromScene(scene: self.scene)
        self.scene.topHUD.barTimer.removeFromParent()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MenuState.self
    }
    
    
}
