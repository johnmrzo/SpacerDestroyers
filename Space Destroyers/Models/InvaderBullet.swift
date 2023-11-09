//
//  InvaderBullet.swift
//  Space Destroyers
//
//  Created by Bakhtiyorjon Mirzajonov on 11/9/23.
//

import SpriteKit

class InvaderBullet: Bullet {
  override init(imageName: String, bulletSound:String?){
    super.init(imageName: imageName, bulletSound: bulletSound)
    // more to come once we add some physics to the game...

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
