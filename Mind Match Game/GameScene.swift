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
import AdSupport
import AppTrackingTransparency

class GameScene: SKScene {
    
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
        
        // For ad tracking
        requestPermission()

        // Listen for didResignActive and save state
        NotificationCenter.default.addObserver(self, selector: #selector(pauseGame), name: NSNotification.Name.pauseGame, object: nil)
        
        // Initialize the managers
        cardManager = CardManager(viewSize: self.size)
        gameManager = GameManager()
        stateMachine = GKStateMachine(states: [FirstRun(scene: self),
                                        MenuState(scene: self),
                                               SetupState(scene: self),
                                               MemorizeState(scene: self),
                                               MatchState(scene: self),
                                               LostLevelState(scene: self),
                                               WonLevelState(scene: self)])
        
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

        
        // First Run Hud
        firstRun = FirstRunHud(size: CGSize(width: size.width * 0.90, height: size.height * 0.40))
        firstRun.position = CGPoint(x: frame.midX, y: frame.midY)
        
        // Launch first run hud if first run is false, else launch menu state
        if !gameManager.firstRun {
            stateMachine?.enter(FirstRun.self)
        } else if gameManager.firstRun {
            stateMachine?.enter(MenuState.self)
        }
//        if gameManager.firstRun == false {
//            firstRun = FirstRunHud(size: CGSize(width: size.width * 0.90, height: size.height * 0.70))
//            firstRun.position = CGPoint(x: frame.midX, y: frame.midY)
//            firstRun.firstRunHudButton.delegate = self
//            addChild(firstRun)
//        } else if gameManager.firstRun == true {
//            self.run(SKAction.wait(forDuration: 2.0)) {
//                self.stateMachine?.enter(MenuState.self)
//                NotificationCenter.default.post(name: .showBannerAd, object: nil)
//            }
//
//
//        }

        
    }
    
    //   https://medium.com/@nish.bhasin/how-to-get-idfa-in-ios14-54f7ea02aa42
    func requestPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    // Tracking authorization dialog was shown
                    // and we are authorized
                    print("Authorized")
                    
                    // Now that we are authorized we can get the IDFA
                    print(ASIdentifierManager.shared().advertisingIdentifier)
                case .denied:
                    // Tracking authorization dialog was
                    // shown and permission is denied
                    print("Denied")
                case .notDetermined:
                    // Tracking authorization dialog has not been shown
                    print("Not Determined")
                case .restricted:
                    print("Restricted")
                @unknown default:
                    print("Unknown")
                }
            }
        } else {
            // Fallback on earlier versions
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

