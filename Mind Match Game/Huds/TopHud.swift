//
//  TopHud.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 11/24/20.
//  Copyright © 2020 Drew Brokamp. All rights reserved.
//

import SpriteKit

class TopHud: SKSpriteNode {
    
    private var background: SKShapeNode!
    private var scoreBox: HudBox!
    private var levelBox: HudBox!
    private var boxSize: CGSize!
    
    public var barTimer: Timer!
    
    init(size: CGSize) {
        
        super.init(texture: nil, color: .clear, size: size)
        self.name = "TopHud"
        self.zPosition = ViewZPositions.hud
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.boxSize = CGSize(width: self.size.height * 0.40,
                              height: self.size.height * 0.30)
        setupBackground()
        setupBarTimer(barColor: .auroraGreen, actionLabelText: "Ready?")
        setupScoreBox()
        setupLevelBox()
    }
    
    private func setupBackground() {
        background = SKShapeNode(rectOf: self.size)
        background.fillColor = .darkSapphire
        background.lineWidth = 0.0
        background.zPosition = ViewZPositions.hudObject
        background.alpha = 0.75
        self.addChild(background)
    }
    
    public func setupBarTimer(barColor: UIColor, actionLabelText: String) {
        barTimer = Timer(width: self.frame.size.width * 0.60,
                         height: self.frame.size.height * 0.30,
                         color: barColor,
                         labelText: actionLabelText)
        barTimer.name = "barTimer"
        barTimer.position = CGPoint(x: 0 - barTimer.frame.width / 2,
                                    y: 0 - barTimer.frame.height - 10)
        self.addChild(barTimer)
    }
    
    public func updateBoxDataLabels(score: String, level: String) {
        self.scoreBox.setDataLabelText(text: score)
        self.levelBox.setDataLabelText(text: level)
    }
    
    public func scoreLabel(text: String) {
        scoreBox.setDataLabelText(text: text)
    }
    
    public func levelLabel(text: String) {
        levelBox.setDataLabelText(text: text)
    }
    
    private func setupScoreBox() {
        scoreBox = HudBox(boxSize: self.boxSize,
                          labelText: "Score",
                          dataLabelText: "")
        scoreBox.position = CGPoint(x: 0 - (self.barTimer.frame.width / 2) - (scoreBox.frame.width / 2) - 20.0,
                                    y: barTimer.position.y + scoreBox.frame.height / 2)
        self.addChild(scoreBox)
    }
    
    private func setupLevelBox() {
        levelBox = HudBox(boxSize: self.boxSize,
                          labelText: "Level",
                          dataLabelText: "")
        levelBox.position = CGPoint(x: 0 + (self.barTimer.frame.width / 2) + (levelBox.frame.width / 2) + 20.0,
                                    y: barTimer.position.y + levelBox.frame.height / 2)
        self.addChild(levelBox)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
