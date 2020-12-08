//
//  GameScene.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//["SFPro-Regular", "SFPro-Ultralight", "SFPro-Thin", "SFPro-Light", "SFPro-Medium", "SFPro-Semibold", "SFPro-Bold", "SFPro-Heavy", "SFPro-Black"]
/*
 
 GameScene initializes all the huds, objects, and labels
 
 Use the Game States to change screen objects
 
 */
import SpriteKit
import GameplayKit

class GameScene: SKScene, ButtonProtocol {
    
    // Class managers
    var stateMachine: GKStateMachine?
    var cardManager: CardManager!
    var gameManager: GameManager!
    
    // HUDs
    var topHUD: TopHud!
    var bottomHUD: BottomHud!
    
    // Menus
    var menu: Menu!
    var results: Results!
    
    //First Run
    var firstRun: FirstRunHud!
    
    override func didMove(to view: SKView) {
        
        backgroundColor = .livid
                
        // Listen for didResignActive and save state
        NotificationCenter.default.addObserver(self, selector: #selector(pauseGame), name: NSNotification.Name.pauseGame, object: nil)
        
        // Initialize the managers
        cardManager = CardManager(viewSize: self.size)
        gameManager = GameManager()
        stateMachine = GKStateMachine(states: [MenuState(scene: self),
                                               SetupState(scene: self),
                                               MemorizeState(scene: self),
                                               MatchState(scene: self),
                                               LostLevelState(scene: self),
                                               WonLevelState(scene: self)])
        
        // Launch first run hud if first run is false, else launch menu state
        if gameManager.firstRun == false {
            firstRun = FirstRunHud(size: CGSize(width: size.width * 0.90, height: size.height * 0.70))
            firstRun.position = CGPoint(x: frame.midX, y: frame.midY)
            firstRun.firstRunHudButton.delegate = self
            addChild(firstRun)
        } else if gameManager.firstRun == true {
            self.run(SKAction.wait(forDuration: 2.0)) {
                self.stateMachine?.enter(MenuState.self)
                NotificationCenter.default.post(name: .showBannerAd, object: nil)
            }

            
        }

        
        // Start Menu
        menu = Menu(size: CGSize(width: size.width / 1.5, height: size.height * 0.25))
        menu.setOnAndOffScreenMenuPositions(onScreen: CGPoint(x: frame.minX + menu.frame.width / 2 - 20.0,
                                                              y: frame.midY + menu.frame.height),
                                            offScreen: CGPoint(x: frame.minX - menu.frame.width / 2,
                                                               y: frame.midY + menu.frame.height))
        

        menu.setInitialPosition(at: .offScreen)
        menu.scoreLabel(text: "\(gameManager.score)")
        menu.levelLabel(text: "\(gameManager.level)")
        addChild(menu)
        
        // Top Hud
        topHUD = TopHud(size: CGSize(width: size.width, height: size.height * 0.12))
        topHUD.position = CGPoint(x: self.view!.frame.midX, y: self.view!.frame.maxY + topHUD.frame.height / 2)
        topHUD.scoreLabel(text: "\(gameManager.score)")
        topHUD.levelLabel(text: "\(gameManager.level)")

        addChild(topHUD)
        
        // Results Menu
        results = Results(size: CGSize(width: size.width / 1.5,
                                       height: size.height * 0.25),
                          inScene: self)
        results.position = CGPoint(x: frame.maxX + results.size.width / 2,
                                   y: (frame.midY - frame.minY) / 1.75)
        addChild(results)


        
        bottomHUD = BottomHud(size: CGSize(width: size.width, height: size.height * 0.12))
        bottomHUD.name = "bottomHUD"
        bottomHUD.position = CGPoint(x: self.view!.frame.midX,
                                     y: self.view!.frame.minY - bottomHUD.frame.height / 1.75)
        addChild(bottomHUD)
        
        // Add the bottomHUD for ads to the scene
        bottomHUD.run(SKAction.moveTo(y: self.view!.frame.minY + bottomHUD.frame.height / 2, duration: 1.0))
        
    }
    
    func buttonPressed(sender: Button) {
        if sender.name == "firstRunHudButton" {
            self.firstRun.run(SKAction.fadeAlpha(to: 0.0, duration: 2.0))
            self.run(SKAction.wait(forDuration: 2.2)) {
                self.stateMachine?.enter(MenuState.self)
                NotificationCenter.default.post(name: .showBannerAd, object: nil)
                self.firstRun.removeAllChildren()
                self.firstRun.removeAllActions()
                self.firstRun.removeFromParent()
//                self.gameManager.firstRun = true
            }

        } else {
            print("No button pressed")
        }
    }
    
    public func updateLabels(score: String, level: String) {
        self.topHUD.updateBoxDataLabels(score: score, level: level)
        self.menu.updateDataLabels(score: score, level: level)
    }
        
    @objc func pauseGame() {
        scene?.isPaused = true
        gameManager.saveGame()
    }
    
    
    
}

