//
//  GameScene.swift
//  AngryBirdsClone
//
//  Created by Alperen KARACA on 28.08.2024.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var enemy = SKSpriteNode()
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    var gameStarted = false
    
    var originalPosition : CGPoint?
    
    enum ColliderType : UInt32 {
        
        case Bird = 1
        case Box = 2
        case Enemy = 3
        
    }
    
    override func didMove(to view: SKView) {
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        
//        Bird
        
        bird = childNode(withName: "bird") as! SKSpriteNode
        
        let birdTexture = SKTexture(imageNamed: "Bird")
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 10)
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.15
        
        originalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Enemy.rawValue
        
        

//        Box
        
        let boxTexture = SKTexture(imageNamed: "Box")
        let size = CGSize(width: boxTexture.size().width / 5 , height: boxTexture.size().height / 5)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.allowsRotation = true
        box1.physicsBody?.mass = 0.05
        
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        box2.physicsBody?.mass = 0.05
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.allowsRotation = true
        box3.physicsBody?.mass = 0.05
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.allowsRotation = true
        box4.physicsBody?.mass = 0.05
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.allowsRotation = true
        box5.physicsBody?.mass = 0.05
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
//        Enemy
        
        let enemyTexture = SKTexture(imageNamed: "Obstacle")
        let enemySize = CGSize(width: enemyTexture.size().width / 10 , height: enemyTexture.size().height / 10)
        
        enemy = childNode(withName: "enemy") as! SKSpriteNode
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemySize)
        enemy.physicsBody?.isDynamic = true
        enemy.physicsBody?.affectedByGravity = true
        enemy.physicsBody?.allowsRotation = true
        enemy.physicsBody?.mass = 0.15
        
        enemy.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
//        ScoreLabel
        
        scoreLabel.fontName = "NewTimesRoman"
        scoreLabel.fontSize = 60
        scoreLabel.fontColor = UIColor.black
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            score += 1
            scoreLabel.text = String(score)
            
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        bird.physicsBody?.affectedByGravity = true
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        }
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition!.x)
                                let dy = -(touchLocation.y - originalPosition!.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.angularVelocity = 0
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.zPosition = 1
                bird.position = originalPosition!
                
                gameStarted = false 
                
            }
        }
        
    }
}
