//
//  LostLevelState.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/30/20.
//

import GameplayKit

class LostLevelState: GKState {
    
    var scene: GameScene
    
    // Init this state with the GameScene.swift as its scene
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    // When this state enters:
    override func didEnter(from previousState: GKState?) {
        print("LostLevelState")
        
        setResultsHud()


        
        // Disable all cards and flip them face up
        scene.cardManager.disableAllCards()
        scene.cardManager.flipCardsFaceUp()

        // Reset the timer bar and label
        scene.topHUD.barTimer.removeFromParent()
        scene.topHUD.setupBarTimer(barColor: .mandarinRed, actionLabelText: "Level Not Complete")

        // Flip the cards face down, stack them, move tophud out of scene, move to MenuState
        let block = SKAction.run {
            
            self.scene.run(SKAction.wait(forDuration: 1.0)) {
                self.scene.cardManager.flipCardsFaceDown()
                self.stackCards()
                self.scene.topHUD.run(SKAction.moveTo(y: self.scene.frame.maxY + self.scene.topHUD.frame.height / 2 , duration: 1.0))
                
            }
            
            
            self.scene.run(SKAction.wait(forDuration: 3.0)) {
                self.scene.stateMachine.enter(MenuState.self)
            }
        }
        
        self.scene.run(block)
        
    }
    
    private func setResultsHud() {
        scene.resultsHUD.setupResultsTitle(text: "Level Not Complete")
        self.scene.resultsHUD.setResultsDataLabels()
        self.scene.resultsHUD.moveMenu(to: .onScreen)
    }
    
    private func stackCards() {
        
        var counter = scene.cardManager.cards.count
        let wait = SKAction.wait(forDuration: 0.05)
        
        let block = SKAction.run {
            [unowned self] in
            
            if counter > 0  {
                counter -= 1
                self.scene.cardManager.cards[counter].run(SKAction.move(to: CGPoint(x: scene.frame.maxX + self.scene.cardManager.getCardSize().width,
                                                                                    y: scene.frame.midY), duration: 0.5))
                
                
            } else {
                scene.removeAction(forKey: "countdown")

            }
        }
        
        let sequence = SKAction.sequence([wait,block])
        
        scene.run(SKAction.repeatForever(sequence), withKey: "countdown")
        
        
    }
    
    // When this state exits, save the game, remove the cards, remove the tophud and all its children
    override func willExit(to nextState: GKState) {
        // Save the game
        scene.gameManager.saveGame()
        self.scene.cardManager.removeCardsFromScene(scene: self.scene)
        self.scene.cardManager.cards.removeAll()
        self.scene.topHUD.barTimer.removeFromParent()

    }
    
    // Make MenuState the only valid state to move to after LostLevelState
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MenuState.self
    }
    
}
