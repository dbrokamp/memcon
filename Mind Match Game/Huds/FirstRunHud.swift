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
    private var firstSlide: SKNode!
    private var secondSlide: SKNode!
    private var thirdSlide: SKNode!
    private var fourthSlide: SKNode!
    
    public var slide: Slides {
        didSet {
            print(slide)
        }
    }
    
    init(size: CGSize) {
        slide = .first
        
        super.init(texture: nil, color: .clear, size: size)
        self.zPosition = ViewZPositions.firstRunHud
        
        setupBackground()
        setupButton()
        setupFirstSlide()
        setupSecondSlide()
        setupThirdSlide()
        setupFourthSlide()
        
    }
    
    public func changeSlide(toSlide: Slides) {
        switch toSlide {
        case .first:
            self.secondSlide.alpha = 0.0
            self.thirdSlide.alpha = 0.0
            self.fourthSlide.alpha = 0.0
        case .second:
            self.firstSlide.run(SKAction.fadeAlpha(to: 0.0, duration: 0.25))
            self.run(SKAction.wait(forDuration: 0.25)) {
                self.secondSlide.run(SKAction.fadeAlpha(to: 1.0, duration: 0.25))
            }
            self.slide = .second
        case .third:
            self.secondSlide.run(SKAction.fadeAlpha(to: 0.0, duration: 0.25))
            self.run(SKAction.wait(forDuration: 0.25)) {
                self.thirdSlide.run(SKAction.fadeAlpha(to: 1.0, duration: 0.25))
            }
            self.slide = .third
        case .fourth:
            self.thirdSlide.run(SKAction.fadeAlpha(to: 0.0, duration: 0.25))
            self.run(SKAction.wait(forDuration: 0.25)) {
                self.fourthSlide.run(SKAction.fadeAlpha(to: 1.0, duration: 0.25))
            }
            self.slide = .fourth
            self.firstRunHudButton.label.text = "Close"
        case .complete:
            self.fourthSlide.run(SKAction.fadeAlpha(to: 0.0, duration: 0.25))
            self.slide = .complete
        }
    }
    
    
    
    private func setupBackground() {
        let background = SKShapeNode(rectOf: self.size, cornerRadius: 20.0)
        background.fillColor = .darkSapphire
        background.lineWidth = 0.0
        background.zPosition = ViewZPositions.firstRunHudBackground
        background.alpha = 0.95
        self.addChild(background)
    }
    
    private func setupFirstSlide() {
        firstSlide = SKNode()
        firstSlide.zPosition = ViewZPositions.firstRunHudLabel
        firstSlide.alpha = 1.0
        self.addChild(firstSlide)
        
        let titleMessageOne = Label(text: "Welcome to")
        titleMessageOne.position = CGPoint(x: 0, y: 0 + 10)
        firstSlide.addChild(titleMessageOne)
        
        let titleMessageTwo = Label(text: "Memory + Concentration!")
        titleMessageTwo.position = CGPoint(x: 0, y: titleMessageOne.position.y - titleMessageOne.frame.height - 10.0)
        firstSlide.addChild(titleMessageTwo)
        
        
    }
    
    private func setupSecondSlide() {
        secondSlide = SKNode()
        secondSlide.zPosition = ViewZPositions.firstRunHudLabel
        secondSlide.alpha = 0.0

        self.addChild(secondSlide)
        
        let scoringLabel = HudBox(boxSize: CGSize(width: self.size.width / 3, height: self.size.height / 10), labelText: "", dataLabelText: "Scoring")
        scoringLabel.position = CGPoint(x: 0,
                                        y: self.frame.maxY - scoringLabel.frame.height)
        secondSlide.addChild(scoringLabel)
        
        let scoreDirectionsOne = Label(text: "One point per match made.")
        scoreDirectionsOne.position = CGPoint(x: self.frame.minX + 10,
                                              y: scoringLabel.position.y - scoringLabel.frame.height * 2.0)
        scoreDirectionsOne.horizontalAlignmentMode = .left
        secondSlide.addChild(scoreDirectionsOne)
        
        let scoreDirectionsTwo = Label(text: "Incorrect matches subtract from you")
        scoreDirectionsTwo.position = CGPoint(x: scoreDirectionsOne.position.x,
                                              y:  scoreDirectionsOne.position.y - scoreDirectionsTwo.frame.height * 2.5)
        scoreDirectionsTwo.horizontalAlignmentMode = .left
        secondSlide.addChild(scoreDirectionsTwo)

        let scoreDirectionsTwoTwo = Label(text: "final score.")
        scoreDirectionsTwoTwo.horizontalAlignmentMode = .left
        scoreDirectionsTwoTwo.position = CGPoint(x: scoreDirectionsOne.position.x,
                                                 y: scoreDirectionsTwo.position.y - scoreDirectionsTwoTwo.frame.height)
        secondSlide.addChild(scoreDirectionsTwoTwo)
        
        let scoreDirectionsThree = Label(text: "There is no deduction for flipping the")
        scoreDirectionsThree.position = CGPoint(x: scoreDirectionsOne.position.x,
                                                y: scoreDirectionsTwoTwo.position.y - scoreDirectionsThree.frame.height * 2.5)
        scoreDirectionsThree.horizontalAlignmentMode = .left
        secondSlide.addChild(scoreDirectionsThree)
        
        let scoreDirectionsThreeTwo = Label(text: "same card.")
        scoreDirectionsThreeTwo.position = CGPoint(x: scoreDirectionsOne.position.x,
                                                   y: scoreDirectionsThree.position.y - scoreDirectionsThree.frame.height)
        scoreDirectionsThreeTwo.horizontalAlignmentMode = .left
        secondSlide.addChild(scoreDirectionsThreeTwo)
        
    }
    
    private func setupThirdSlide() {
        thirdSlide = SKNode()
        thirdSlide.zPosition = ViewZPositions.firstRunHudLabel
        thirdSlide.alpha = 0.0
        
        self.addChild(thirdSlide)
        
        let memorizeLabel = HudBox(boxSize: CGSize(width: self.size.width / 3, height: self.size.height / 10), labelText: "", dataLabelText: "Timers")
        memorizeLabel.position = CGPoint(x: 0, y: self.frame.maxY - memorizeLabel.frame.height)
        self.thirdSlide.addChild(memorizeLabel)
        
        let memorizeOne = Label(text: "Memorize timer starts at 15 seconds.")
        memorizeOne.horizontalAlignmentMode = .left
        memorizeOne.position = CGPoint(x: self.frame.minX + 10,
                                       y: memorizeLabel.position.y - memorizeLabel.frame.height * 2.0)
        self.thirdSlide.addChild(memorizeOne)
        
        let memorizeTwo = Label(text: "Every level increase decreases the")
        memorizeTwo.horizontalAlignmentMode = .left
        memorizeTwo.position = CGPoint(x: memorizeOne.position.x, y: memorizeOne.position.y - memorizeTwo.frame.height)
        self.thirdSlide.addChild(memorizeTwo)
        
        let memorizeThree = Label(text: "memorize timer by 1 second.")
        memorizeThree.horizontalAlignmentMode = .left
        memorizeThree.position = CGPoint(x: memorizeOne.position.x, y: memorizeTwo.position.y - memorizeThree.frame.height)
        self.thirdSlide.addChild(memorizeThree)
        
        let matchOne = Label(text: "Match timer starts at 45 seconds.")
        matchOne.horizontalAlignmentMode = .left
        matchOne.position = CGPoint(x: memorizeOne.position.x, y: memorizeThree.position.y - memorizeThree.frame.size.height * 2.5)
        self.thirdSlide.addChild(matchOne)
        
        let matchTwo = Label(text: "Every level increase decreases the")
        matchTwo.horizontalAlignmentMode = .left
        matchTwo.position = CGPoint(x: memorizeOne.position.x, y: matchOne.position.y - matchTwo.frame.height)
        self.thirdSlide.addChild(matchTwo)
        
        let matchThree = Label(text: "match timer by 1 second.")
        matchThree.horizontalAlignmentMode = .left
        matchThree.position = CGPoint(x: memorizeOne.position.x, y: matchTwo.position.y - matchThree.frame.height)
        self.thirdSlide.addChild(matchThree)
    }
    
    private func setupFourthSlide() {
        fourthSlide = SKNode()
        fourthSlide.zPosition = ViewZPositions.firstRunHudLabel
        fourthSlide.alpha = 0.0
        self.addChild(fourthSlide)
        
        let goodLuckOne = Label(text: "Get ready to test your memory!")
        goodLuckOne.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        fourthSlide.addChild(goodLuckOne)
        
        let goodLuckTwo = Label(text: "Good Luck!")
        goodLuckTwo.position = CGPoint(x: self.frame.midX,
                                       y: goodLuckOne.position.y - goodLuckOne.frame.height)
        fourthSlide.addChild(goodLuckTwo)
    }
    
    private func setupButton() {
        firstRunHudButton = Button(text: "Continue", size: CGSize(width: self.frame.width / 3, height: self.frame.height / 10))
        firstRunHudButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + firstRunHudButton.frame.height)
        firstRunHudButton.zPosition = ViewZPositions.firstRunHudLabel
        firstRunHudButton.name = "firstRunHudButton"
        firstRunHudButton.adjustLabelFontSizeToFitRect(labelNode: self.firstRunHudButton.label, rect: self.firstRunHudButton.frame)
        self.addChild(firstRunHudButton)
    }
    
    private func setupLayout() {
        

        

        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
