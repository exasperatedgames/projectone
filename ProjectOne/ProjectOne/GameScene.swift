//
//  GameScene.swift
//  ProjectOne
//
//  Created by Steven Gross on 12/30/17.
//  Copyright © 2017 Exasperated Games. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var gorilla = SKSpriteNode()
    var yeti = SKSpriteNode()
    var snowball = SKSpriteNode()
    var stone = SKSpriteNode()
    let gorillaIdle = SKAction.init(named: "gorilla_idle")!
    let gorillaRun = SKAction.init(named: "gorilla_run")!
    let gorillaThrow = SKAction.init(named: "gorilla_throw")!
    let yetiIdle = SKAction.init(named: "yeti_idle")!
    let yetiRun = SKAction.init(named: "yeti_run")!
    let yetiThrow = SKAction.init(named: "yeti_throw")!
    let safePoint = CGPoint(x: 10000, y: 10000)
    
    
    var snowball2 = Projectile()
    
    
    override func didMove(to view: SKView) {
        if let node = childNode(withName: "gorilla") {
            self.gorilla = node as! SKSpriteNode
        }
        if let node = childNode(withName: "yeti") {
            self.yeti = node as! SKSpriteNode
        }
        
        snowball = SKSpriteNode(imageNamed: "Snowball")
        stone = SKSpriteNode(imageNamed: "Stone")
        
        
        
        
        
        let snowballBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Snowball"), size: CGSize(width: snowball.size.width, height: snowball.size.height))
        snowball.physicsBody = snowballBody
        
        let stoneBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Stone"), size: CGSize(width: stone.size.width, height: stone.size.height))
        stone.physicsBody = stoneBody
        snowball.physicsBody?.categoryBitMask = 2
        //snowball.physicsBody?.contactTestBitMask = 1
        snowball.name = "snowball"
        stone.name = "stone"
        //stone.physicsBody?.contactTestBitMask = 1
        stone.physicsBody?.categoryBitMask = 2
        
        
        snowball.physicsBody?.isDynamic = false
        snowball.physicsBody?.affectedByGravity = false
        stone.physicsBody?.isDynamic = false
        stone.physicsBody?.affectedByGravity = false
        
        
        
        snowball.zPosition = 100
        stone.zPosition = 100
        
        
        addChild(snowball)
        addChild(stone)
        
        snowball.position = CGPoint(x: 10000, y: 10000)
        stone.position = CGPoint(x: 10000, y: 10000)
        
        
        gorilla.run(gorillaIdle)
        yeti.run(yetiIdle)
        yeti.xScale = -yeti.xScale
        
        
        physicsWorld.contactDelegate = self
        
        
//        snowball2 = Projectile(imageNamed: "Snowball")
//        addChild(snowball2)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == "stone" && nodeB.name == "yeti" {
            stone.removeAllActions()
            stone.run(SKAction.move(to: safePoint, duration: 0.0))
        } else if nodeB.name == "stone" && nodeA.name == "yeti" {
            stone.removeAllActions()
            stone.run(SKAction.move(to: safePoint, duration: 0.0))
        } else if nodeA.name == "snowball" && nodeB.name == "gorilla" {
            snowball.removeAllActions()
            snowball.run(SKAction.move(to: safePoint, duration: 0.0))
        } else if nodeB.name == "snowball" && nodeA.name == "gorilla" {
            snowball.removeAllActions()
            snowball.run(SKAction.move(to: safePoint, duration: 0.0))
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        let node = nodes(at: location!)
        if let name = node.first?.name {
            switch(name) {
                case "gorilla":
                    print("clicked the gorilla")
                    stone.position = CGPoint(x: gorilla.position.x + 120, y: gorilla.position.y + 60)
                    let toss = SKAction.moveTo(x: self.frame.maxX + 100, duration: 1.0)
                    stone.run(toss)
                    gorilla.run(gorillaThrow)
                case "yeti":
                    print("clicked the yeti")
                    let snowball = Projectile(imageNamed: "Snowball")
                    addChild(snowball)
                    snowball.fire(start: CGPoint(x: yeti.position.x - 120, y: yeti.position.y + 60), to: CGPoint(x: gorilla.position.x, y: gorilla.position.y))
                    yeti.run(yetiThrow)
                default: break
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
