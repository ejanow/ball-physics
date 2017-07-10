//
//  GoodObjectView.swift
//  ball-physics
//
//  Created by e on 5/13/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class GoodObjectView: UIView {
    
    let id: UInt32 = arc4random()
    
    // MARK: Draw
    override func draw(_ rect: CGRect) {
        UIColor.green.setFill()
        UIBezierPath(rect: rect).fill()
    }
}
