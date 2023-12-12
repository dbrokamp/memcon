//
//  Hud.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 10/26/21.
//  Copyright © 2021 Drew Brokamp. All rights reserved.
//

import Foundation
import SpriteKit

class Hud: SKSpriteNode {
    
    private var background: SKShapeNode
    
    public var onScreenPosition: CGPoint
    public var offScreenPosition: CGPoint
    public var boxes: [HudBox]?
    public var actionButton: Button?
    
    init(size: CGSize, onScreen: CGPoint, offScreen: CGPoint) {
        self.background = SKShapeNode()
        self.onScreenPosition = onScreen
        self.offScreenPosition = offScreen
        
        super.init(texture: nil, color: .clear, size: size)
        setupBackground()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBackground() {
        background = SKShapeNode(rectOf: self.size, cornerRadius: Globals.HudBackground.cornerRadius)
        background.fillColor = .darkSapphire
        background.lineWidth = Globals.HudBackground.lineWidth
        background.zPosition = Globals.ViewZPositions.hudBackground
        background.alpha = Globals.HudBackground.transparency
        self.addChild(background)
        
    }
    

    public func setButtonPosition(position: CGPoint) {
        
    }
}
