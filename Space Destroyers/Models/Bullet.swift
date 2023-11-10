//
//  Bullet.swift
//  Space Destroyers
//
//  Created by Bakhtiyorjon Mirzajonov on 11/9/23.
//

import UIKit
import SpriteKit

class Bullet: SKSpriteNode {
  init(imageName: String, bulletSound: String?) {
    let texture = SKTexture(imageNamed: imageName)
    super.init(texture: texture, color: SKColor.clear, size: texture.size())
    if(bulletSound != nil){
      run(SKAction.playSoundFileNamed(bulletSound!, waitForCompletion: false))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
