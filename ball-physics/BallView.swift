//
//  BallView.swift
//  ball-physics
//
//  Created by e on 5/10/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class BallView: UIView {
    
    var velocity: CGPoint = CGPoint.zero
    
    public func move() {
        
        guard self.velocity != CGPoint.zero else {
            return
        }
        
        DispatchQueue.main.async {
            self.center.x += self.velocity.x
            self.center.y += self.velocity.y
        }
        
        self.checkForWallCollisions()
    }
    
    private func checkForWallCollisions() {
        
        guard let view = superview
            else { return }
        
        let spacing = CGFloat(26)
        //let scoreboardHeight = CGFloat(50)
        
        let rightWall = view.bounds.width - spacing
        let leftWall = spacing
        let topWall = spacing
        let bottomWall = view.bounds.height - spacing
        
        let ballX = self.center.x
        let ballY = self.center.y
        
        if ballX > rightWall || ballX < leftWall {
            
            self.adjustVelocity(type: .wall, flip: .x)
            self.printDebug("Hit X")
            DispatchQueue.main.async {
                self.center.x = (ballX < leftWall ? leftWall + 1 : rightWall - 1)
            }
        }
        
        if ballY > bottomWall || ballY < topWall {
            
            self.adjustVelocity(type: .wall, flip: .y)
            self.printDebug("Hit Y")
            DispatchQueue.main.async {
                self.center.y = (ballY < topWall ? topWall + 1 : bottomWall - 1)
            }
        }
        
        self.adjustVelocity(type: .incremental)
    }
    
    private func adjustVelocity(type: DragType, flip: Axis? = nil) {
        
        let wallDrag = CGFloat(0.5)
        let incDrag = CGFloat(0.9777)
        
        switch type {
        case .wall:
            self.multiplyVelocity(by: wallDrag)
        case .incremental:
            self.multiplyVelocity(by: incDrag)
        }
        
        guard let axis = flip
            else { return }
        
        self.flip(axis: axis)
    }
    
    public func multiplyVelocity(by f: CGFloat) {
        
        self.velocity.x *= f
        self.velocity.y *= f
        
        self.setVelFloors()
    }
    
    public func addVelocity(x: CGFloat, y: CGFloat) {
        self.velocity.x += x
        self.velocity.y += y
    }
    
    public func flip(axis: Axis) {
        switch axis {
        case .x:
            self.velocity.x *= -1
        case .y:
            self.velocity.y *= -1
        }
    }
    
    public func getVelocityMagnitude() -> CGFloat {
        let x = self.velocity.x
        let y = self.velocity.y
        let mag = sqrt((x * x) + (y * y))
        return CGFloat(mag)
    }
    
    private func setVelFloors() {
        let floor = CGFloat(0.5)
        if self.getVelocityMagnitude() < floor {
            self.velocity = CGPoint.zero
        }
    }
    
    private func printDebug(_ msg: String) {
        print("-------------------------")
        print(msg)
        print("velocity: \(self.velocity)")
        print("Ball:     \(self.center)")
        print("-------------------------")
    }
    
    // Mark: Draw
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.orange.setFill()
        path.fill()
    }
}
