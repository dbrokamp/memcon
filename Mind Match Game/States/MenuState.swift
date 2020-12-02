//
//  MenuState.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//

/*
    -   Show an intersitial ad if conditions are met
    -   Move center hud menu into view
    -


 */

import GameplayKit

class MenuState: GKState, ButtonProtocol {
    
    private var scene: GameScene
    
    init(scene: GameScene) {
        
        self.scene = scene
        
        super.init()
        
    }
    
    override func didEnter(from previousState: GKState?) {
        print("MenuState")
        
        scene.updateLabels(score: "\(scene.gameManager.score)", level: "\(scene.gameManager.level)")
        
        if scene.gameManager.playAdCounter > 1 && scene.gameManager.playAdCounter % 3 == 0 {
            NotificationCenter.default.post(name: .showInterstitialAd, object: nil)
        }
        
        scene.menu.setButtonDelegate(buttonDelegate: self)
        scene.menu.moveMenu(to: .onScreen)
        

        scene.cardManager.createArrayOfCards(scene: self.scene)
        scene.cardManager.createCardPositions(scene: self.scene)
        scene.cardManager.addCardsToCardScene(scene: self.scene)
        scene.cardManager.placeCardsOffScreen(scene: self.scene)
        scene.cardManager.cards.shuffle()
        scene.cardManager.stackCards(inScene: self.scene)
        scene.cardManager.disableAllCards()
        
    }
    
    // Delegate message sent to this function when Action Button sent
    func buttonPressed(sender: Button) {
        
        let block = SKAction.run {
            
            // Move the centerHUD off the screen
            self.scene.menu.moveMenu(to: .offScreen)
            
            // Move the resultsHUD off the screen if a game has been played
            if self.scene.gameManager.playAdCounter > 0 {
                self.scene.results.run(SKAction.moveTo(x: self.scene.frame.maxX + self.scene.results.size.width / 2,
                                                       duration: 1.0))
            }
            
            // Enter the SetupState
            self.scene.run(SKAction.wait(forDuration: 1.2)) {
                self.scene.stateMachine?.enter(SetupState.self)
            }
        }
        
        
        scene.run(block)
        
        
    }
    
    override func willExit(to nextState: GKState) {
        
        // Save the game
        scene.gameManager.saveGame()
        
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        return stateClass == SetupState.self
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    
    
}
