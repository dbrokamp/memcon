//
//  NewGameMemorizeState.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//
//  ----------------------------------------------------------------------------------------------
//
//
//  This state allows time for the player to memorize the card pairs and their location
//      - Check memorizeCountDown function for full description
//
//  Exits to MatchState
//
//
//  ----------------------------------------------------------------------------------------------

import GameplayKit

class MemorizeState: GKState {
    
    private weak var scene: GameScene?
    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == MatchState.self
    }
    
    override func didEnter(from previousState: GKState?) {
        print("MemorizeState")
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        // Wait a beat then enter the memorize countdown
        scene.run(SKAction.wait(forDuration: 1.0)) {
            self.memorizeCountDown()
        }
        
        
    }
    
    override func willExit(to nextState: GKState) {
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        // Save the game
        scene.gameManager.saveGame()
    }
    
    // Removes and adds barTimer to reset it
    // Flips all cards face up
    // Changes bar timer to yellow and red
    // Decreases timerBar
    // Exits this state to MatchState
    
    func memorizeCountDown() {
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        var timer = scene.gameManager.memorizeTimer
        scene.topHUD.barTimer.removeFromParent()
        scene.topHUD.setupBarTimer(barColor: .auroraGreen, actionLabelText: "Memorize: \(timer)")
        
        scene.cardManager.flipCardsFaceUp()
        
        let turnYellow = Double(timer) * 0.50
        let turnRed = Double(timer) * 0.25
        
        let wait = SKAction.wait(forDuration: 1.0)
        
        let block = SKAction.run {
            if timer > 0  {
                timer -= 1
                if timer <= Int(turnYellow) {
                    scene.topHUD.barTimer.changeTimerBarColor(newColor: .squashBlossom)
                }
                
                if timer <= Int(turnRed) {
                    scene.topHUD.barTimer.changeTimerBarColor(newColor: .mandarinRed)
                }
                
                scene.topHUD.barTimer.decreaseTimerBar(currentWidth: scene.topHUD.barTimer.size.width,
                                                hudDecreaseBy: scene.topHUD.barTimer.size.width / CGFloat(timer),
                                                decreaseDuration: 1.0)
                scene.topHUD.barTimer.changeActionLabel(newText: "Memorize: \(timer)")
                
            } else {
                scene.removeAction(forKey: "countdown")
                scene.topHUD.barTimer.removeFromParent()
                scene.stateMachine.enter(MatchState.self)
            }
        }
        
        let sequence = SKAction.sequence([wait,block])
        
        scene.run(SKAction.repeatForever(sequence), withKey: "countdown")
        
    }
    
    
}
