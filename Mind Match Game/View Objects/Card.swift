//
//  Card.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//

import SpriteKit

protocol CardSelected: AnyObject {
    func cardSelected(sender: Card)
}

class Card: SKSpriteNode {
    
    // Private properties
    private let flipCard = SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.10), SKAction.scale(to: 1.0, duration: 0.10)])        // Scale up, then scale down to original
    private var faceDownColor: UIColor = .forestBlues
    private var faceUpColor: UIColor = .lynxWhite//.dupain
    private var faceUpSymbol: SKSpriteNode!
    private var faceDownSymbol: SKSpriteNode!
    private var isFaceUp: Bool = false {
        didSet {
            self.run(flipCard)
            self.color = isFaceUp ? faceUpColor : faceDownColor                 // If isFaceUp == true show faceUpColor, else faceDownColor
            self.faceDownSymbol.isHidden = isFaceUp ? true : false               // If isFaceUp == true, hide faceDownImage, else show faceDownImage
            self.faceUpSymbol.isHidden = isFaceUp ? false : true                 // If isFaceUp == true, show faceUpImage, else hide faceUpImage
        }
    }
    private var isSelected: Bool = false {
        didSet {
            self.alpha = isSelected ? 0.75 : 1.0                                // If isSelected == true, alpha = 0.75, else alpha = 1.0
        }
    }
    
    // Public properties
    weak var delegate: CardSelected?
    public var identifier: Int = 0
    

    // MARK: Init
    init(size: CGSize, image: String) {
        
        super.init(texture: nil, color: faceDownColor, size: size)
        self.name = "card.\(identifier).\(image)"
        self.isUserInteractionEnabled = true
        self.zPosition = ViewZPositions.cards
        
        // Setup faceUpSymbol and hide
        self.faceUpSymbol = setupSymbol(withImage: image)
        self.faceUpSymbol.zPosition = ViewZPositions.symbols
        faceUpSymbol.isHidden = true
        self.addChild(faceUpSymbol)
        
        // Setup faceDownSymbol
        self.faceDownSymbol = setupSymbol(withImage: "sparkles")
        self.addChild(faceDownSymbol)
        
        // Add rounded corners to the cards
        setupRoundedCorners()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Create sprite node with symbol name
    private func setupSymbol(withImage: String) -> SKSpriteNode {
        let image = UIImage(systemName: withImage, withConfiguration: SymbolConfigurations.configuration)
        let texture = SKTexture(image: image!)
        let sprite = SKSpriteNode(texture: texture)
        sprite.color = .clear
        sprite.zPosition = ViewZPositions.symbols
        sprite.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        return sprite
    }
    
    // Adds rounded corners by using a shapenode
    private func setupRoundedCorners() {
        let mask = SKShapeNode(rect: CGRect(x: self.position.x - self.size.width / 2,
                                            y: self.position.y - self.size.height / 2,
                                            width: self.size.width,
                                            height: self.size.height),
                               cornerRadius: 3.0)
        mask.strokeColor = UIColor(red: 10/255, green: 61/255, blue: 98/255, alpha: 1.0)
        mask.lineWidth = 2.3
        mask.fillColor = .clear
        self.addChild(mask)
    }
    
    public func flipCardFaceUp() {
        isFaceUp = true
    }
    
    public func flipCardFaceDown() {
        isFaceUp = false
    }
    
    // MARK: Touches Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !(self.frame.contains(touches.first!.location(in: parent!))) {
            isSelected = false
        } else {
            isSelected = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isSelected == true && isFaceUp == false {
            self.delegate?.cardSelected(sender: self)
            self.flipCardFaceUp()
        } else if isSelected == true && isFaceUp == true {
            self.delegate?.cardSelected(sender: self)
            self.flipCardFaceDown()
        }
        
        isSelected = false
        
    }
    
    
}
