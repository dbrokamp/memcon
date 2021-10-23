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



class GameScene: SKScene {
    
    // Class managers
    var stateMachine: GKStateMachine
    var cardManager: CardManager
    var gameManager: GameManager
    
    // HUDs
    var topHUD: TopHud
    var bottomHUD: BottomHud
    
    // Menus
    var menuHUD: MenuHud
    var resultsHUD: ResultsHud
    
    //First Run
    var firstRun: FirstRunHud?
    
    
    //MARK: Init
    override init(size: CGSize) {
        
        // Initialize Managers
        stateMachine = GKStateMachine(states: [])
        cardManager = CardManager(viewSize: size)
        gameManager = GameManager()
        
        // Initialize HUDs
        topHUD = TopHud(size: CGSize(width: size.width, height: size.height * 0.12))
        bottomHUD = BottomHud(size: CGSize(width: size.width, height: size.height * 0.12))
        menuHUD = MenuHud(size: CGSize(width: size.width / 1.5, height: size.height * 0.25))
        resultsHUD = ResultsHud(size: CGSize(width: size.width / 1.5,
                                       height: size.height * 0.25))

        // Super Class Initializer
        super.init(size: size)
        
        // Setup Game States
        stateMachine = GKStateMachine(states: [FirstRun(scene: self),
                                        MenuState(scene: self),
                                               SetupState(scene: self),
                                               MemorizeState(scene: self),
                                               MatchState(scene: self),
                                               LostLevelState(scene: self),
                                               WonLevelState(scene: self)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: didMove(to view:)
    override func didMove(to view: SKView) {
        
        //Set the background color
        backgroundColor = .livid

        // Listen for didResignActive and save state
        NotificationCenter.default.addObserver(self, selector: #selector(pauseGame), name: NSNotification.Name.pauseGame, object: nil)
        
        // Set positions of MenuHud

        menuHUD.setOnAndOffScreenMenuPositions(onScreen: CGPoint(x: frame.minX + menuHUD.frame.width / 2 - 20.0,
                                                              y: frame.midY + menuHUD.frame.height),
                                            offScreen: CGPoint(x: frame.minX - menuHUD.frame.width / 2,
                                                               y: frame.midY + menuHUD.frame.height))
        menuHUD.setInitialPosition(at: .offScreen)
        menuHUD.scoreLabel(text: "\(gameManager.score)")
        menuHUD.levelLabel(text: "\(gameManager.level)")
        addChild(menuHUD)
        
        // Set position of top hud
        topHUD.position = CGPoint(x: self.view!.frame.midX, y: self.view!.frame.maxY + topHUD.frame.height / 2)
        topHUD.scoreLabel(text: "\(gameManager.score)")
        topHUD.levelLabel(text: "\(gameManager.level)")
        addChild(topHUD)
        
        
        // Setup position and size of results hud
        resultsHUD.position = CGPoint(x: frame.maxX + resultsHUD.size.width / 2,
                                   y: (frame.midY - frame.minY) / 1.75)
        addChild(resultsHUD)


        
        // Setup position for bottom hud
        bottomHUD.name = "bottomHUD"
        bottomHUD.position = CGPoint(x: self.view!.frame.midX,
                                     y: self.view!.frame.minY - bottomHUD.frame.height / 1.75)
        addChild(bottomHUD)
        
        // Launch first run hud if first run is false, else launch menu state
        if !gameManager.firstRun {
            stateMachine.enter(FirstRun.self)
        } else if gameManager.firstRun {
            stateMachine.enter(MenuState.self)
        }
    }
    
    public func updateLabels(score: String, level: String) {
        self.topHUD.updateBoxDataLabels(score: score, level: level)
        self.menuHUD.updateDataLabels(score: score, level: level)
    }
        
    @objc func pauseGame() {
        scene?.isPaused = true
        gameManager.saveGame()
    }
    
    
    
}

