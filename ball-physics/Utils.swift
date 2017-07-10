//
//  Utils.swift
//  ball-physics
//
//  Created by e on 5/13/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

struct Utils {
    
    
    public static func getRandomCoordinate(_ view: UIView) -> CGPoint {
        
        let spacing = CGFloat(25)
        let spacingInt = UInt32(spacing)
        
        let rightWall = UInt32(view.bounds.width - spacing)
        let bottomWall = UInt32(view.bounds.height - spacing)
        
        let x = spacingInt + arc4random_uniform(rightWall - spacingInt)
        let y = spacingInt + arc4random_uniform(bottomWall - spacingInt)
        
        let point = CGPoint(x: Int(x), y: Int(y))
        
        return point
    }
    
    public static func LogError(_ msg: Any) {
        LogError([msg])
    }
    
    public static func LogError(_ errors: [Any]) {
        
        log("------------------ERROR------------------")
        
        for e in errors {
            self.log(e)
        }
        
        log("-----------------------------------------")
        
    }
    
    public static func log(_ items: [Any]) {
        
        log("------------------DEBUG------------------")
        
        for i in items {
            log(i)
        }
        
        log("-----------------------------------------")
        
        
    }
    
    private static func log(_ x: Any) {
        
        print(x) // write this to file? Sned to PagerDuty? Etc etc.
    }}
