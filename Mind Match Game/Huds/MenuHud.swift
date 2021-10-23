//
//  Menu.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 11/10/20.
//  Copyright © 2020 Drew Brokamp. All rights reserved.
//

import SpriteKit

class MenuHUD: SKSpriteNode {
    
    enum ViewPosition {
        case onScreen, offScreen
    }
    
    private var background: SKShapeNode!
    private var actionButton: Button!
    private var scoreBox: HudBox!
    private var levelBox: HudBox!
    private var offScreenPosition: CGPoint!
    private var onScreenPosition: CGPoint!
    
    init(size: CGSize) {
        
        super.init(texture: nil, color: .clear, size: size)
        self.name = "menu"
        self.zPosition = ViewZPositions.hud
        
        setupBackground()
        setupButton()
        setupScoreBox()
        setupLevelBox()
    }
    
    public func updateDataLabels(score: String, level: String) {
        self.scoreBox.setDataLabelText(text: score)
        self.levelBox.setDataLabelText(text: level)
    }
    
    public func moveMenu(to: ViewPosition) {
        switch to {
        case .onScreen:
            self.run(SKAction.move(to: onScreenPosition, duration: 1.0))
        case .offScreen:
            self.run(SKAction.move(to: offScreenPosition, duration: 1.0))
        }
        
    }
    
    public func setInitialPosition(at: ViewPosition) {
        switch at {
        case .onScreen:
            self.position = onScreenPosition
        case .offScreen:
            self.position = offScreenPosition
        }
    }
    
    public func setOnAndOffScreenMenuPositions(onScreen: CGPoint, offScreen: CGPoint) {
        onScreenPosition = onScreen
        offScreenPosition = offScreen
    }
    
    public func setButtonDelegate(buttonDelegate: ButtonProtocol) {
        actionButton.delegate = buttonDelegate
    }
    
    public func scoreLabel(text: String) {
        scoreBox.setDataLabelText(text: text)
    }
    
    public func levelLabel(text: String) {
        levelBox.setDataLabelText(text: text)
    }
    
    private func setupBackground() {
        background = SKShapeNode(rectOf: self.size, cornerRadius: 20.0)
        background.fillColor = UIColor(red: 12/255, green: 36/255, blue: 97/255, alpha: 1.0)  // French Palette Dark Sapphire rgb(12, 36, 97)
        background.lineWidth = 0.0
        background.zPosition = ViewZPositions.hudObject
        background.alpha = 0.75
        self.addChild(background)
    }
    
    private func setupButton() {
        actionButton = Button(text: "Start Game",
                              size: CGSize(width: self.size.width * 0.5,
                                           height: self.size.height * 0.15))
        actionButton.name = "actionButton"
        actionButton.position = CGPoint(x: 0, y: 0 - actionButton.frame.height * 1.25)
        actionButton.adjustLabelFontSizeToFitRect(labelNode: self.actionButton.label, rect: self.actionButton.frame)
        actionButton.zPosition = ViewZPositions.hudBox
        self.addChild(actionButton)
    }
    
    private func setupScoreBox() {
        scoreBox = HudBox(boxSize: CGSize(width: size.width * 0.20, height: size.height * 0.20),
                          labelText: "Score",
                          dataLabelText: "")
        scoreBox.position = CGPoint(x: 0 - scoreBox.frame.width, y: 0 + scoreBox.frame.height / 1.25)
        self.addChild(scoreBox)
    }
    
    private func setupLevelBox() {
        levelBox = HudBox(boxSize: CGSize(width: size.width * 0.20, height: size.height * 0.20),
                          labelText: "Level",
                          dataLabelText: "")
        levelBox.position = CGPoint(x: 0 + levelBox.frame.width, y: 0 + levelBox.frame.height / 1.25)
        self.addChild(levelBox)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
