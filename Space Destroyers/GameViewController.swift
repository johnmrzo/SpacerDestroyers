//
//  GameViewController.swift
//  Space Destroyers
//
//  Created by Bakhtiyorjon Mirzajonov on 11/9/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      let scene = StartGameScene(size: view.bounds.size)
      let skView = view as! SKView
      skView.showsFPS = true
      skView.showsNodeCount = true
      skView.ignoresSiblingOrder = true
      scene.scaleMode = .resizeFill
      skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
