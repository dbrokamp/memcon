//
//  NewGameMatchState.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//

import GameplayKit

class MatchState: GKState, CardSelected {
    
    
    private weak var scene: GameScene?
    
    var firstCard: Card?
    var secondCard: Card?

    
    init(scene: GameScene) {
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        print("MatchState")
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        scene.gameManager.resetGameVariables()
        
        // Make this state the CardSelected protocol class delegate for each card
        for card in scene.cardManager.cards {
            card.delegate = self
        }
        
        matchCountDown()
    }
    
    public func cardSelected(sender: Card) {
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        if firstCard == nil {
            
            firstCard = sender
            
        } else if firstCard != nil {
            
            secondCard = sender
            scene.cardManager.disableAllCards()
            
            if firstCard == secondCard {
                
                print("Flipped same card")
                firstCard?.flipCardFaceDown()
                firstCard = nil
                secondCard = nil
                scene.cardManager.enableAllCards()
                
            } else if firstCard != secondCard {
                
                if firstCard?.identifier == secondCard?.identifier {
                    print("match made!")
                    // increase score, remove cards
                    scene.gameManager.numberOfMatchesMade += 1
                    
                    scene.run(SKAction.wait(forDuration: 0.25)) {
                        
                        self.firstCard?.removeFromParent()
                        self.secondCard?.removeFromParent()
                        self.firstCard = nil
                        self.secondCard = nil
                    }
                    
                    if scene.gameManager.numberOfMatchesMade == scene.gameManager.numberOfMatchesPossible {
                        
                        print("Level Won")
                        
                        scene.run(SKAction.wait(forDuration: 0.25)) {
                            
                            scene.topHUD.barTimer.removeFromParent()
                            scene.removeAction(forKey: "countdown")
                            scene.stateMachine.enter(WonLevelState.self)
                            
                        }
                    } else {
                        
                        scene.cardManager.enableAllCards()
                        
                    }
                    
                } else if firstCard?.identifier != secondCard?.identifier {
                    
                    scene.run(SKAction.wait(forDuration: 0.25)) {
                        
                        print("not a match")
                        scene.gameManager.numberOfIncorrectMatches += 1
                        self.firstCard?.flipCardFaceDown()
                        self.secondCard?.flipCardFaceDown()
                        self.firstCard = nil
                        self.secondCard = nil
                        scene.cardManager.enableAllCards()
                        
                    }
                }
            }
            
        }
        
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == WonLevelState.self || stateClass == LostLevelState.self
    }
    
    override func willExit(to nextState: GKState) {
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        // Save the game
        scene.gameManager.saveGame()
        scene.gameManager.calculateLevelPoints()
        
        // Reset the match variables
        firstCard = nil
        secondCard = nil

    }
    
    private func matchCountDown() {
        
        // Safely check to see if scene is loaded, else fatalError
        guard let scene = scene else { fatalError("The scene did not load!") }
        
        var timer = scene.gameManager.matchTimer
        let turnYellow = Double(timer) * 0.50
        let turnRed = Double(timer) * 0.25
        scene.topHUD.barTimer.removeFromParent()
        scene.topHUD.setupBarTimer(barColor: .auroraGreen, actionLabelText: "Match \(timer)")

        
        // Flip and enable all cards
        scene.cardManager.flipCardsFaceDown()
        scene.cardManager.enableAllCards()
        
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
                scene.topHUD.barTimer.changeActionLabel(newText: "Match: \(timer)")
                
            } else {
                
                scene.removeAction(forKey: "countdown")
                scene.topHUD.barTimer.removeFromParent()
                scene.stateMachine.enter(LostLevelState.self)
                
            }
            
            
        }
        
        let sequence = SKAction.sequence([wait,block])
        
        scene.run(SKAction.repeatForever(sequence), withKey: "countdown")
        
    }
}
