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
        background.fillColor = .darkSapphire
        background.lineWidth = 0.0
        background.zPosition = ViewZPositions.firstRunHudBackground
        background.alpha = 0.95
        self.addChild(background)
    }
    
    private func setupLayout() {
        let scoringLabel = HudBox(boxSize: CGSize(width: self.size.width / 3, height: self.size.height / 16), labelText: "", dataLabelText: "Scoring")
        scoringLabel.position = CGPoint(x: 0, y: self.frame.maxY - scoringLabel.frame.height)
        scoringLabel.zPosition = ViewZPositions.firstRunHudLabel
        self.addChild(scoringLabel)
        
        let scoreDirectionsOne = Label(text: "One point per match made.")
        scoreDirectionsOne.horizontalAlignmentMode = .left
        
        let scoreDirectionsTwo = Label(text: "Incorrect matches subtract from")
        scoreDirectionsTwo.position = CGPoint(x: scoreDirectionsOne.position.x,
                                              y:  scoreDirectionsOne.frame.midY - scoreDirectionsTwo.frame.height * 2.5)
        scoreDirectionsTwo.horizontalAlignmentMode = .left
        let scoreDirectionsTwoTwo = Label(text: "your final score.")
        scoreDirectionsTwoTwo.horizontalAlignmentMode = .left
        scoreDirectionsTwoTwo.position = CGPoint(x: scoreDirectionsOne.position.x,
                                                 y: scoreDirectionsTwo.position.y - scoreDirectionsTwoTwo.frame.height)
        
        let scoreDirectionsThree = Label(text: "There is no deduction for flipping")
        scoreDirectionsThree.position = CGPoint(x: scoreDirectionsOne.position.x,
                                                y: scoreDirectionsTwoTwo.frame.midY - scoreDirectionsThree.frame.height * 2.5)
        scoreDirectionsThree.horizontalAlignmentMode = .left
        
        let scoreDirectionsThreeTwo = Label(text: "the same card.")
        scoreDirectionsThreeTwo.position = CGPoint(x: scoreDirectionsOne.position.x,
                                                   y: scoreDirectionsThree.position.y - scoreDirectionsThree.frame.height)
        scoreDirectionsThreeTwo.horizontalAlignmentMode = .left
        
        let scoreDirections = SKNode()
        scoreDirections.addChild(scoreDirectionsOne)
        scoreDirections.addChild(scoreDirectionsTwo)
        scoreDirections.addChild(scoreDirectionsTwoTwo)
        scoreDirections.addChild(scoreDirectionsThree)
        scoreDirections.addChild(scoreDirectionsThreeTwo)
        scoreDirections.zPosition = ViewZPositions.firstRunHudLabel
        scoreDirections.position = CGPoint(x: self.frame.minX + 10, y: scoringLabel.position.y - scoringLabel.frame.height * 1.5)
        self.addChild(scoreDirections)
        
        let memorizeLabel = HudBox(boxSize: scoringLabel.size, labelText: "", dataLabelText: "Timers")
        memorizeLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(memorizeLabel)
        
        let memorizeDirections = SKNode()
        memorizeDirections.zPosition = ViewZPositions.firstRunHudLabel
        memorizeDirections.position = CGPoint(x: self.frame.minX + 10, y: memorizeLabel.position.y - memorizeLabel.frame.height * 1.5)
        self.addChild(memorizeDirections)
        
        let memorizeOne = Label(text: "Memorize timer starts at 15 seconds,")
        memorizeOne.horizontalAlignmentMode = .left
        memorizeDirections.addChild(memorizeOne)
        
        let memorizeTwo = Label(text: "every level increase, decreases the")
        memorizeTwo.horizontalAlignmentMode = .left
        memorizeTwo.position = CGPoint(x: memorizeOne.position.x, y: memorizeOne.position.y - memorizeOne.frame.height)
        memorizeDirections.addChild(memorizeTwo)
        
        let memorizeThree = Label(text: "memorize timer by 1 second.")
        memorizeThree.horizontalAlignmentMode = .left
        memorizeThree.position = CGPoint(x: memorizeOne.position.x, y: memorizeTwo.position.y - memorizeTwo.frame.height)
        memorizeDirections.addChild(memorizeThree)
        
        let matchOne = Label(text: "Match timer starts at 45 seconds,")
        matchOne.horizontalAlignmentMode = .left
        matchOne.position = CGPoint(x: memorizeOne.position.x, y: memorizeThree.position.y - memorizeThree.frame.size.height * 2.5)
        memorizeDirections.addChild(matchOne)
        
        let matchTwo = Label(text: "every level increase, decreases the")
        matchTwo.horizontalAlignmentMode = .left
        matchTwo.position = CGPoint(x: memorizeOne.position.x, y: matchOne.position.y - matchOne.frame.height)
        memorizeDirections.addChild(matchTwo)
        
        let matchThree = Label(text: "match timer by 1 second.")
        matchThree.horizontalAlignmentMode = .left
        matchThree.position = CGPoint(x: memorizeOne.position.y, y: matchTwo.position.y - matchTwo.frame.height)
        memorizeDirections.addChild(matchThree)
        
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
