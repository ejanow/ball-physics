//
//  BadObjectView.swift
//  ball-physics
//
//  Created by e on 5/13/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class BadObjectView: UIView {
    
    let id: UInt32 = arc4random()

    override func draw(_ rect: CGRect) {
        UIColor.red.setFill()
        UIBezierPath(rect: rect).fill()
    }
}
