//
//  GameSetupState.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//
//
//  ----------------------------------------------------------------------------------------------
//
//
//  This state sets up the game by:
//      - Resetting the timer bar and pulling down the topHUD
//      - Moves the cards into the grid positions
//
//  Exits to MemorizeState
//
//
//  ----------------------------------------------------------------------------------------------


import GameplayKit

class SetupState: GKState, PositionCards {

    private weak var scene: GameScene?
    
    //MARK: INIT
    init(scene: GameScene) {
        self.scene = scene
        
        super.init()
    }
    
    //MARK: DIDENTER
    override func didEnter(from previousState: GKState?) {
        print("SetupState")
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        // Move the centerHUD off the screen
        scene.menuHUD.moveMenu(to: .offScreen)
        
        // TODO: If the resultsHud exists, move it off screen
        
        // Remove and add timer bar to reset it
        scene.topHUD.barTimer.removeFromParent()
        scene.topHUD.setupBarTimer(barColor: .auroraGreen, actionLabelText: "Memorize: ")
        
        // Set SetupState as the delegate for positionCardsDelegate
        scene.cardManager.positionCardsDelegate = self
        
        // Move the tophud into view
        scene.topHUD.run(SKAction.moveTo(y: scene.frame.maxY - scene.topHUD.frame.height / 2, duration: 1.0))
        
        // Shuffle the card positions and move the cards into the grid
        scene.cardManager.positionCardsInGrid(inScene: scene)
        
    }
    
    // Action to take when delegate message received that positioning cards is complete
    func positionCardsComplete(sender: CardManager) {
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        scene.stateMachine.enter(MemorizeState.self)
        
    }
    
    // Actions to take when SetupState exits
    override func willExit(to nextState: GKState) {
        
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        // Save the game
        scene.gameManager.saveGame()

    }
    
    // Sets MemorizeState as only valid next state
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MemorizeState.self
    }
    
}
