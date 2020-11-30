//
//  Results.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 11/23/20.
//  Copyright © 2020 Drew Brokamp. All rights reserved.
//
//--------------------------------------------------------------------
//
// Creates HUD for results after each level played
//
//--------------------------------------------------------------------


import SpriteKit

class Results: SKSpriteNode {
    
    weak var gameScene: GameScene?
    private var background: SKShapeNode?
    private var title: Label?
    private var possibleMatchesBox: HudBox?
    private var matchesMade: HudBox?
    private var incorrectMatches: HudBox?
    private var totalPoints: HudBox?
    private var sizeFactor: CGFloat = 0.15
    
    // MARK: Init
    init(size: CGSize, inScene: GameScene) {
        self.gameScene = inScene
        
        super.init(texture: nil, color: .clear, size: size)
        self.name = "results"
        self.zPosition = ViewZPositions.hud
        setupBackground()
        setupPossibleMatchesBox()
        setupMatchesMadeBox()
        setupIncorrectMatchesMadeBox()
        setupTotalPointsBox()
    }
    
    public func setupResultsTitle(text: String) {
        title = Label(text: text)
        title?.fontName = "SFPro-Bold"
        title?.position = CGPoint(x: 0.0, y: 0.0 + (self.frame.height / 2) - (title!.frame.height * 1.5))
        self.addChild(title!)
    }
    
    public func setResultsDataLabels() {
        possibleMatchesBox?.setDataLabelText(text: "\(self.gameScene?.gameManager.numberOfMatchesPossible ?? 0)")
        matchesMade?.setDataLabelText(text: "\(self.gameScene?.gameManager.numberOfMatchesMade ?? 0)")
        incorrectMatches?.setDataLabelText(text: "\(self.gameScene?.gameManager.numberOfIncorrectMatches ?? 0)")
        totalPoints?.setDataLabelText(text: "\(Int(self.gameScene!.gameManager.levelPointsCalc))")
    }
    
    private func setupBackground() {
        background = SKShapeNode(rectOf: self.size, cornerRadius: 20.0)
        background?.lineWidth = 0.0
        background?.fillColor = UIColor(red: 12/255, green: 36/255, blue: 97/255, alpha: 1.0)  // French Palette Dark Sapphire rgb(12, 36, 97)
        background?.zPosition = ViewZPositions.hudObject
        background?.alpha = 0.75
        self.addChild(background!)
    }
    

    private func setupPossibleMatchesBox() {
        possibleMatchesBox = HudBox(boxSize: CGSize(width: size.width * sizeFactor,
                                                    height: size.height * sizeFactor),
                                    labelText: "Possible Matches",
                                    dataLabelText: "15")
        possibleMatchesBox?.position = CGPoint(x: 0 + self.frame.width / 4.0, y: 0 + possibleMatchesBox!.frame.height + 10.0)
        possibleMatchesBox?.alignLabelLeft()
        self.addChild(possibleMatchesBox!)
    }
    
    private func setupMatchesMadeBox() {
        matchesMade = HudBox(boxSize: CGSize(width: size.width * sizeFactor,
                                                    height: size.height * sizeFactor),
                                    labelText: "Matches Made",
                                    dataLabelText: "15")
        matchesMade?.position = CGPoint(x: 0 + self.frame.width / 4.0, y: 0)
        matchesMade?.alignLabelLeft()
        self.addChild(matchesMade!)
    }
    
    private func setupIncorrectMatchesMadeBox() {
        incorrectMatches = HudBox(boxSize: CGSize(width: size.width * sizeFactor,
                                                    height: size.height * sizeFactor),
                                    labelText: "Incorrect Matches",
                                    dataLabelText: "15")
        incorrectMatches?.position = CGPoint(x: 0 + self.frame.width / 4.0, y: 0 - incorrectMatches!.frame.height - 10.0)
        incorrectMatches?.alignLabelLeft()
        self.addChild(incorrectMatches!)
    }
    
    private func setupTotalPointsBox() {
        totalPoints = HudBox(boxSize: CGSize(width: size.width * sizeFactor,
                                                    height: size.height * sizeFactor),
                                    labelText: "Total Points",
                                    dataLabelText: "15")
        totalPoints?.position = CGPoint(x: 0 + self.frame.width / 4.0, y: 0 - totalPoints!.frame.height - 10.0 - totalPoints!.frame.height - 10.0)
        totalPoints?.alignLabelLeft()
        self.addChild(totalPoints!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

