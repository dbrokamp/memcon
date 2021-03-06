//
//  Hud.swift
//  Memory+Concentration
//
//  Created by Drew Brokamp on 10/31/20.
//
/*
 
 Subclasses SKSpriteNode to create a hud container
 
 */

import SpriteKit

class BottomHud: SKSpriteNode {
    
    init(size: CGSize) {
        
        super.init(texture: nil, color: .darkSapphire, size: size)  // French Palette Dark Sapphire rgb(12, 36, 97)
        self.alpha = 0.75
        self.zPosition = ViewZPositions.hud
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


