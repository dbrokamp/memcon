//
//  CardManager.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//

import SpriteKit

protocol PositionCards: class {
    func positionCardsComplete(sender: CardManager)
}

class CardManager {

    weak var positionCardsDelegate: PositionCards?
    
    public var cards: Array<Card>
    
    private var cardPositions: Array<CGPoint>
    private var cardSize: CGSize
    
    init(viewSize: CGSize) {
        
        cardSize = CGSize()
        cards = [Card]()
        cardPositions = [CGPoint]()
        
    }
    
    public func disableAllCards() {
        for card in cards {
            card.isUserInteractionEnabled = false
        }
    }
    
    public func enableAllCards() {
        for card in cards {
            card.isUserInteractionEnabled = true
        }
    }
    
    public func positionCardsInGrid(inScene: GameScene) {
        var counter = cards.count
        
        let wait = SKAction.wait(forDuration: 0.05)
        
        let block = SKAction.run {
            [unowned self] in
            
            if counter > 0  {
                counter -= 1
                cards[counter].run(SKAction.move(to: cardPositions[counter], duration: 0.5))
                
                
            } else {
                inScene.removeAction(forKey: "countdown")
                self.positionCardsDelegate?.positionCardsComplete(sender: self)
            }
        }
        
        let sequence = SKAction.sequence([wait,block])
        
        inScene.run(SKAction.repeatForever(sequence), withKey: "countdown")
    }
    
    public func stackCards(inScene: GameScene) {
        
        var counter = cards.count
        
        let wait = SKAction.wait(forDuration: 0.10)
        
        let block = SKAction.run {
            [unowned self] in
            
            if counter > 0  {
                counter -= 1
                cards[counter].run(SKAction.move(to: CGPoint(x: inScene.frame.midX,
                                                             y: inScene.frame.midY), duration: 0.5))
                
                
            } else {
                inScene.removeAction(forKey: "countdown")

            }
        }
        
        let sequence = SKAction.sequence([wait,block])
        
        inScene.run(SKAction.repeatForever(sequence), withKey: "countdown")
        
    }
    
    public func removeCardsFromScene(scene: GameScene) {
        for card in cards {
            card.removeFromParent()
        }
    }
    
    public func addCardsToCardScene(scene: GameScene) {
        for card in cards {
            scene.addChild(card)
        }
    }
    
    public func centerCardsInGrid(scene: GameScene) {
        for card in cards {
            card.position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        }
    }
    
    public func placeCardsOffScreen(scene: GameScene) {
        for card in cards {
            card.position = CGPoint(x: scene.frame.maxX + card.frame.width / 2,
                                    y: scene.frame.midY)
        }
    }
    
    public func flipCardsFaceUp() {
        for card in cards {
            card.flipCardFaceUp()
        }
    }
    
    public func flipCardsFaceDown() {
        for card in cards {
            card.flipCardFaceDown()
        }
    }
    
    public func createCardPositions(scene: GameScene) {
        
        
        let startingXPosition = scene.frame.midX - (cardSize.width / 2) - 10 - cardSize.width - 10 - (cardSize.width / 2)
        let startingYPosition = scene.frame.midY - (cardSize.height / 2) - 10 - cardSize.height - 10 - cardSize.height
        var rowCounter = 0
        var columnCounter = 0
        var xPosition = startingXPosition
        var yPosition = startingYPosition
        
        while rowCounter < 6 {
            
            while columnCounter < 5 {
                let newPosition = CGPoint(x: xPosition, y: yPosition)
                cardPositions.append(newPosition)
                columnCounter += 1
                xPosition = xPosition + cardSize.width + 10
            }
            columnCounter = 0
            xPosition = startingXPosition
            
            rowCounter += 1
            yPosition = yPosition + cardSize.height + 10
        }
        
    }
    
    public func createArrayOfCards(scene: GameScene) {
        let cardOptions = ["mic.fill", "bubble.left.fill", "phone.fill", "envelope.fill",
                           "waveform.circle.fill", "square.and.arrow.up.fill",
                           "pencil", "scribble.variable", "trash", "lasso", "folder.fill", "paperplane.fill",
                           "externaldrive.fill", "doc.fill", "book.fill", "newspaper.fill",
                           "circle.grid.cross.fill", "gamecontroller.fill", "b.circle",
                           "r.rectangle.roundedbottom.fill", "keyboard", "goforward.15",
                           "dollarsign.circle.fill", "creditcard.fill", "bandage.fill", "heart.fill",
                           "cross.fill", "sum", "equal.circle.fill", "bolt.fill"]
        let numberOfCards = 30
        let height = scene.size.height / 9.5
        let width = height * 0.75
        cardSize = CGSize(width: width, height: height)
        
        var counter = 0
        var chosenNumbers = [Int]()
        
        while counter < numberOfCards {
            
            let randomNumber = Int.random(in: 0...cardOptions.count - 1)
            
            ifAlreadyChosen: if chosenNumbers.contains(randomNumber) {
                
                break ifAlreadyChosen   // Ensures symbols are used once
                
            } else {
                
                let card1 = Card(size: cardSize, image: cardOptions[randomNumber])
                card1.identifier = randomNumber
                cards.append(card1)
                
                counter += 1
                
                let card2 = Card(size: cardSize, image: cardOptions[randomNumber])
                card2.identifier = randomNumber
                cards.append(card2)
                
                counter += 1
                
                chosenNumbers.append(randomNumber)
                
            }
            
        }

    }
    
}
