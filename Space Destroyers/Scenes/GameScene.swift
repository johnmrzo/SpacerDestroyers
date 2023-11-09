//
//  GameScene.swift
//  Space Destroyers
//
//  Created by Bakhtiyorjon Mirzajonov on 11/9/23.
//

import SpriteKit
import GameplayKit

var levelNum = 1

class GameScene: SKScene {
  
  let rowsOfInvaders = 4
  var invaderSpeed = 2
  let leftBounds = CGFloat(30)
  var rightBounds = CGFloat(0)
  var invadersWhoCanFire:[Invader] = [Invader]()  // will increase with each level
  let player:Player = Player()
  let maxLevels = 3
  
  private var label : SKLabelNode?
  private var spinnyNode : SKShapeNode?
  
  override func didMove(to view: SKView) {
    
    backgroundColor = SKColor.black
    setupInvaders()
    setupPlayer()
    invokeInvaderFire()
    
    // Get label node from scene and store it for use later
    self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
    if let label = self.label {
      label.alpha = 0.0
      label.run(SKAction.fadeIn(withDuration: 2.0))
    }
    
    // Create shape node to use during mouse interaction
    let w = (self.size.width + self.size.height) * 0.05
    self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
    
    if let spinnyNode = self.spinnyNode {
      spinnyNode.lineWidth = 2.5
      
      spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
      spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                        SKAction.fadeOut(withDuration: 0.5),
                                        SKAction.removeFromParent()]))
    }
  }
  
  func touchDown(atPoint pos : CGPoint) {
    
  }
  
  func touchMoved(toPoint pos : CGPoint) {
    
  }
  
  func touchUp(atPoint pos : CGPoint) {
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    player.fireBullet(scene: self)
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
  
  // MARK: - Invader Methods
  func setupInvaders(){
    var invaderRow = 0;
    var invaderColumn = 0;
    let numberOfInvaders = levelNum * 2 + 1
    for i in 1...rowsOfInvaders {
      invaderRow = i
      for j in 1...numberOfInvaders {
        invaderColumn = j
        let tempInvader:Invader = Invader()
        let invaderHalfWidth:CGFloat = tempInvader.size.width/2
        let xPositionStart:CGFloat = size.width/2 - invaderHalfWidth - (CGFloat(levelNum) * tempInvader.size.width) + CGFloat(10)
        tempInvader.position = CGPoint(x:xPositionStart + ((tempInvader.size.width+CGFloat(10))*(CGFloat(j-1))), y:CGFloat(self.size.height - CGFloat(i) * 46))
        tempInvader.invaderRow = invaderRow
        tempInvader.invaderColumn = invaderColumn
        addChild(tempInvader)
        if(i == rowsOfInvaders){
        invadersWhoCanFire.append(tempInvader)
        }
      }
    }
  }
  
  func moveInvaders(){
    var changeDirection = false
    enumerateChildNodes(withName: "invader") { node, stop in
      let invader = node as! SKSpriteNode
      let invaderHalfWidth = invader.size.width/2
      invader.position.x -= CGFloat(self.invaderSpeed)
      if(invader.position.x > self.rightBounds - invaderHalfWidth || invader.position.x < self.leftBounds + invaderHalfWidth){
        changeDirection = true
      }
    }
    if(changeDirection == true){
      self.invaderSpeed *= -1
      self.enumerateChildNodes(withName: "invader") { node, stop in
        let invader = node as! SKSpriteNode
        invader.position.y -= CGFloat(46)
      }
      changeDirection = false
    }
  }
  
  
  // MARK: - Player Methods
  func setupPlayer() {
    player.position = CGPoint(x: self.frame.midX, y:player.size.height/2 + 10)
    addChild(player)
  }
  
  
  func invokeInvaderFire(){
    let fireBullet = SKAction.run(){
      self.fireInvaderBullet()
    }
    let waitToFireInvaderBullet = SKAction.wait(forDuration: 1.5)
    let invaderFire = SKAction.sequence([fireBullet,waitToFireInvaderBullet])
    let repeatForeverAction = SKAction.repeatForever(invaderFire)
    run(repeatForeverAction)
  }

  func fireInvaderBullet(){
    if(invadersWhoCanFire.isEmpty){
      levelNum += 1
      // Complete the level later by adding its method here! (Part 5)
    }else{
      let randomInvader = invadersWhoCanFire.randomElement()
      randomInvader!.fireBullet(scene: self)
    }
  }
  
}

extension Array where Element: AnyObject {
  func randomElement() -> Element? {
    guard !isEmpty else { return nil }
    let randomIndex = Int(arc4random_uniform(UInt32(count)))
    return self[randomIndex]
  }
}
