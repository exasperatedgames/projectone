//
//  Projectile.swift
//  ProjectOne
//
//  Created by Paul Eyer on 12/30/17.
//  Copyright © 2017 Exasperated Games. All rights reserved.
//

import UIKit
import SpriteKit

class Projectile: SKSpriteNode {
    
    var objSpeed = 1.0
    let animation = SKAction(named: "snowball_animation")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        if let tex = texture {
            physicsBody = SKPhysicsBody(texture: tex, size: size)
            physicsBody?.isDynamic = false
            physicsBody?.affectedByGravity = false
            
            physicsBody?.categoryBitMask = ObjectType.projectile.rawValue
        }
    }
    
    convenience init(imagedNamed:String, speed:Double?) {
        let t = SKTexture(imageNamed: imagedNamed)
        self.init(texture: t, color: .red, size: t.size())
        if let s = speed {
            objSpeed = s
        }
    }
    
    func fire(start:CGPoint, to:CGPoint) {
        removeAllActions()
        run(animation!)
        position = start
        let moveAction = SKAction.move(to: to, duration: objSpeed)
        let finishAction = SKAction.run {
            self.destroy()
        }
        let seq = SKAction.sequence( [moveAction, finishAction] )
        run(seq)
    }
    
    func destroy() {
        removeFromParent()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
