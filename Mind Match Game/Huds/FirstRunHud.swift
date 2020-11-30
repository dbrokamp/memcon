//
//  FirstRunHud.swift
//  Mind Match Game
//
//  Created by Drew Brokamp on 11/30/20.
//  Copyright © 2020 Drew Brokamp. All rights reserved.
//
//
// - Explains point system and memorize and match system timers

import SpriteKit

class FirstRunHud: SKSpriteNode {
    
    private var background: SKShapeNode!
    
    init(size: CGSize) {
        
        super.init(texture: nil, color: .clear, size: size)
        self.zPosition = ViewZPositions.firstRunHud
        
        setupBackground()
        
    }
    
    private func setupBackground() {
        background = SKShapeNode(rectOf: self.size, cornerRadius: 20.0)
        background.fillColor = .black // French Palette Dark Sapphire rgb(12, 36, 97)
        background.lineWidth = 0.0
        background.zPosition = ViewZPositions.firstRunHudBackground
        background.alpha = 0.90
        self.addChild(background)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
