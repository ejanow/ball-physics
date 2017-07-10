//
//  GoodObjectViewFactory.swift
//  ball-physics
//
//  Created by e on 5/13/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

struct ObjectViewFactory {
    
    public static func makeGood(for view: UIView) -> GoodObjectView {
        
        let coor: CGPoint = Utils.getRandomCoordinate(view)
        let objSize = CGFloat(25)
        let objRect = CGRect(x: coor.x, y: coor.y, width: objSize, height: objSize)
        let goodObj = GoodObjectView(frame: objRect)
        DispatchQueue.main.async {
            view.addSubview(goodObj)
            goodObj.setNeedsDisplay()
        }
        
        return goodObj
    }
    
    public static func makeBad(for view: UIView) -> BadObjectView {
        
        let coor: CGPoint = Utils.getRandomCoordinate(view)
        let objSize = CGFloat(25)
        let objRect = CGRect(x: coor.x, y: coor.y, width: objSize, height: objSize)
        let badObj = BadObjectView(frame: objRect)
        DispatchQueue.main.async {
            view.addSubview(badObj)
            badObj.setNeedsDisplay()
        }
        
        return badObj
    }
}
