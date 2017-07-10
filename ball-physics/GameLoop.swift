//
//  GameLoop.swift
//  ball-physics
//
//  Created by e on 5/13/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class GameLoop {
    
    unowned let vc: ViewController
    unowned let ball: BallView
    
    var score: Int = 0
    
    var goodObjects = [GoodObjectView]()
    var badObjects  = [BadObjectView]()
    
    
    init(_ vc: ViewController) {
        self.vc = vc
        self.ball = self.vc.ball
    }
    
    public func loop() {
        checkSpawn()
        checkCollisions()
    }
    
    public func end() {
        DispatchQueue.main.async {
            
            self.goodObjects.forEach { $0.removeFromSuperview() }
            self.badObjects.forEach  { $0.removeFromSuperview() }
            self.goodObjects.removeAll(keepingCapacity: false)
            self.badObjects.removeAll(keepingCapacity: false)
        }
    }
    
    private func checkSpawn(){
        
        guard let gameBoard = vc.gameBoard
            else { return }
        
        if goodObjects.count < 3 {
            let goodObj = ObjectViewFactory.makeGood(for: gameBoard)
            self.goodObjects.append(goodObj)
        }
        
        if badObjects.count < 3 {
            let badObj = ObjectViewFactory.makeBad(for: gameBoard)
            self.badObjects.append(badObj)
        }
        
    }
    
    private func checkCollisions() {
        
        let ballLocation = self.ball.frame
        
        for go in goodObjects {
            
            if go.frame.intersects(ballLocation) {
                DispatchQueue.main.async {
                    self.goodObjects = // For thread safety
                        self.goodObjects.filter { $0.id != go.id }
                    go.removeFromSuperview()
                    self.vc.modifyScore(100)
                }
            }
        }
        
        for bo in badObjects {
            if bo.frame.intersects(ballLocation) {
                DispatchQueue.main.async {
                    self.badObjects = // For thread safety
                        self.badObjects.filter { $0.id != bo.id }
                    
                    bo.removeFromSuperview()
                    self.vc.modifyScore(-100)
                }
            }
        }
    }
}
