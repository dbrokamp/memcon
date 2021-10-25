//
//  MenuState.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//
//  ----------------------------------------------------------------------------------------------
//
//
//  This state occurs prior to the first game and after each game.
//      - Moves the MenuHud onto the screen with score and level labels and Start Game Button
//      - Moves BottomHud into position
//      - Stacks cards in middle of screen
//
//  Exits to the SetupState
//
//
//  ----------------------------------------------------------------------------------------------

import GameplayKit

class MenuState: GKState, ButtonProtocol {
    
    private weak var scene: GameScene?
    
    init(scene: GameScene) {
        
        self.scene = scene
        
        super.init()
        
    }
    
    override func didEnter(from previousState: GKState?) {
        
        print("MenuState")
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }

        // Move bottomHUD
        scene.bottomHUD.run(SKAction.moveTo(y: scene.view!.frame.minY + scene.bottomHUD.frame.height / 2, duration: 1.0))
        
        scene.updateLabels(score: "\(scene.gameManager.score)", level: "\(scene.gameManager.level)")
        
        scene.menuHUD.setButtonDelegate(buttonDelegate: self)
        scene.menuHUD.moveMenu(to: .onScreen)
        
        scene.cardManager.createArrayOfCards(scene: scene)
        scene.cardManager.createCardPositions(scene: scene)
        scene.cardManager.addCardsToCardScene(scene: scene)
        scene.cardManager.placeCardsOffScreen(scene: scene)
        scene.cardManager.cards.shuffle()
        scene.cardManager.stackCards(inScene: scene)
        scene.cardManager.disableAllCards()
        
    }
    
    // Delegate message sent to this function when Start Button is pressed
    
    // Sets the stateMachine to SetupState
    func buttonPressed(sender: Button) {
        
        guard let scene = scene else { fatalError("Scene did not load") }
        
        let block = SKAction.run {
            
            // Enter the SetupState after 1.2 seconds
            scene.run(SKAction.wait(forDuration: 1.2)) {
                
                scene.stateMachine.enter(SetupState.self)
                
            }
        }
        
        scene.run(block)
        
    }
    
    override func willExit(to nextState: GKState) {
        
        // Save the game
        guard let scene  = scene else { return }
        scene.gameManager.saveGame()
        
        
    }
    
    // This state can only exit to the SetupState
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        return stateClass == SetupState.self
        
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        
    }
    
    
    
}
