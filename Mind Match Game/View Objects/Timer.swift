//
//  HUDBar.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/29/20.
//

/*
 
 Subclasses SKSpriteNode to create a progress bar
 
 Action Label is centered in timer bar
 
 */

import SpriteKit

class Timer: SKSpriteNode {
    
    private var originalWidth: CGFloat
    private var originalHeight: CGFloat
    private var actionLabel: Label
    private var label: Label!
    
    init(width: CGFloat, height: CGFloat, color: UIColor, labelText: String) {
        
        // Store initial width of timer to reset its with
        originalWidth = width
        originalHeight = height
        
        // Initialize the action label
        actionLabel = Label(text: labelText)
        
        // Default Super Class initializer
        super.init(texture: nil, color: color, size: CGSize(width: width, height: height))
        
        self.zPosition = ViewZPositions.hudObject
        self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        self.actionLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        // Add action label to timer bar
        self.addChild(actionLabel)
        actionLabel.name = "actionLabel"
        setupRoundedCorners()
        setupLabel()
        
    }
    
    public func saveOriginalSize(width: CGFloat, height: CGFloat) {
        self.originalWidth = width
        self.originalHeight = height
    }
    
    private func setupLabel() {
        label = Label(text: "Action and Timer")
        label.position = CGPoint(x: 0 + self.frame.width / 2,
                                 y: self.frame.maxY + label.frame.height)
        label.name = "actionAndTimer"
        self.addChild(label)
    }
    
    private func setupRoundedCorners() {
        let mask = SKShapeNode(rect: CGRect(x: self.position.x,
                                            y: self.position.y,
                                            width: self.size.width,
                                            height: self.size.height),
                               cornerRadius: 3.0)
        mask.strokeColor = .white
        mask.lineWidth = 2.3
        mask.fillColor = .clear
        mask.name = "timerMask"
        self.addChild(mask)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Decreases the size of the progress bar by the designated duration
    public func decreaseTimerBar(currentWidth: CGFloat, hudDecreaseBy: CGFloat, decreaseDuration: Double) {
        
        let newHUDBar = currentWidth - hudDecreaseBy
        self.run(SKAction.resize(toWidth: newHUDBar, duration: decreaseDuration))
        
    }
    
    // Resets the the progress bar to its original size
    public func resetTimerBarToOriginalWidth() {

        self.run(SKAction.scale(to: CGSize(width: originalWidth, height: self.frame.height), duration: 1.0))
        self.color = .systemGreen

    }
    
    // Changes the color of the progress bar
    public func changeTimerBarColor(newColor: UIColor) {

        self.color = newColor
        
    }
    
    // Change the action label
    public func changeActionLabel(newText: String) {
        
        self.actionLabel.text = newText
        
    }
    
    public func changeActionLabelTextSize(newSize: CGFloat) {
        self.actionLabel.fontSize = newSize
    }
    
    public func flashLabel() {
        
        self.actionLabel.flashLabel()
        
    }
    
    
}

