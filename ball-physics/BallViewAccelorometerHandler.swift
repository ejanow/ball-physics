//
//  BallViewAccelorometerHandler.swift
//  ball-physics
//
//  Created by e on 5/13/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import CoreMotion

class BallViewAccelormeterHandler {
    
    unowned let ball: BallView
    let mm = CMMotionManager()
    
    init(ball: BallView) {
        self.ball = ball
    }
    
    public func begin() {
        guard self.mm.isAccelerometerAvailable
            else { return }
        
        let updateFreq = 10.0
        self.mm.accelerometerUpdateInterval = 1 / updateFreq
        
        self.mm.startAccelerometerUpdates(to: .main) { data, error in
            
            guard error == nil,
                let data = data
            else {
                self.end()
                return
            }
            
            let scalar = 2.0
            let x = CGFloat(data.acceleration.x * scalar)
            let y = CGFloat(data.acceleration.y * scalar * -1.0)
            
            self.ball.addVelocity(x: x, y: y)
        }
    }
    
    public func end() {
        mm.stopAccelerometerUpdates()
    }
    
    private func printDebug(_ a: [Any]) {
        print("---------------------")
        for i in a {
            print(i)
        }
        print("---------------------")
    }
}
