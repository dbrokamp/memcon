//
//  FirstRunHud.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 11/30/20.
//  Copyright © 2020 Drew Brokamp. All rights reserved.
//
//
// - Explains point system and memorize and match system timers
// - Black background, white text

import SpriteKit

class FirstRunHud: SKSpriteNode {
    
    public var firstRunHudButton: Button!
    
    init(size: CGSize) {
        
        super.init(texture: nil, color: .clear, size: size)
        self.zPosition = ViewZPositions.firstRunHud
        
        setupBackground()
        setupLayout()
        
    }
    
    private func setupBackground() {
        let background = SKShapeNode(rectOf: self.size, cornerRadius: 20.0)
        background.fillColor = .black
        background.lineWidth = 0.0
        background.zPosition = ViewZPositions.firstRunHudBackground
        background.alpha = 0.90
        self.addChild(background)
    }
    
    private func setupLayout() {
        let scoringLabel = Label(text: "Scoring")
        scoringLabel.position = CGPoint(x: 0, y: 0)
        scoringLabel.zPosition = ViewZPositions.firstRunHudLabel
        self.addChild(scoringLabel)
        
        firstRunHudButton = Button(text: "Continue", size: CGSize(width: self.frame.width / 2, height: self.frame.height / 20))
        firstRunHudButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + firstRunHudButton.frame.height)
        firstRunHudButton.zPosition = ViewZPositions.firstRunHudLabel
        firstRunHudButton.name = "firstRunHudButton"
        firstRunHudButton.adjustLabelFontSizeToFitRect(labelNode: self.firstRunHudButton.label, rect: self.firstRunHudButton.frame)
        self.addChild(firstRunHudButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
