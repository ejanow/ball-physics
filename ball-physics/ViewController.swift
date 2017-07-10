//
//  ViewController.swift
//  ball-physics
//
//  Created by e on 5/10/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ball: BallView!
    @IBOutlet weak var gameBoard: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let winningScore = 500
    let spacing = CGFloat(26)
    var updating: Bool = false
    var score = 0
    
    var motionHandler: BallViewAccelormeterHandler? = nil
    var gameLoop: GameLoop? = nil
    
    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        guard recognizer.state == .ended
            else { return }
        
        let vel = recognizer.velocity(in: self.view)
        let scalar = CGFloat(0.1)
        
        self.ball.velocity = CGPoint(x: vel.x * scalar, y: vel.y * scalar)
    }
    
    public func modifyScore(_ i: Int) {
        self.score += i
        self.scoreLabel.text = "Score: \(self.score)"
        if self.score >= self.winningScore {
            win()
        }
    }
    
    private func win() {
        self.stopGame()
        
        let ok =
            UIAlertAction(title: "Ok", style: .default)
        
        let winAlert =
            UIAlertController(title: "You win!",
                              message: self.scoreLabel.text ?? "",
                              preferredStyle: .alert)
        
        winAlert.addAction(ok)
        present(winAlert, animated: true) { _ in self.startGame() }
    }
    
    
    private func startGame() {
        
        self.score = 0
        DispatchQueue.main.async {
            self.scoreLabel.text = "Score: \(self.score)"
            self.ball.velocity = CGPoint.zero
            self.ball.center = self.gameBoard.center
        }
        
        self.gameLoop = GameLoop(self)
        
        // Initialize motion handling
        self.motionHandler = BallViewAccelormeterHandler(ball: self.ball)
        self.motionHandler?.begin()
        
        self.updating = true
        self.beginLoop()
    }
    
    private func stopGame() {
        self.updating = false
        self.motionHandler?.end()
        self.motionHandler = nil
        self.gameLoop?.end()
        self.gameLoop = nil
    }
    
    // MARK: Main Game Loop
    
    private func beginLoop() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            while self.updating {
                
                self.ball.move()
                self.gameLoop?.loop()
                usleep(30_000)
            }
        }
    }
    
    // MARK: Lifecycle Methods
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startGame()
    }
}
