//
//  BubbleView.swift
//  Unwind
//
//  Created by Rahel Lüthy on 01.10.18.
//  Copyright © 2018 Scalable. All rights reserved.
//

import UIKit

@IBDesignable
class BubbleView: UIView {
    
    static let borderColor: UIColor = UIColor(hex: 0x292A30)
    static let borderWidth: CGFloat = 2
    
    private let size: CGFloat
    private let fillColor: UIColor
    
    init(frame: CGRect, fillColor: UIColor) {
        size = min(frame.width, frame.height)
        self.fillColor = fillColor
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        let frame = UIScreen.main.bounds
        size = min(frame.width, frame.height)
        self.fillColor = UIColor.black
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        ctx.setLineWidth(BubbleView.borderWidth)
        ctx.setStrokeColor(BubbleView.borderColor.cgColor)
        
        let cornerRadius = size / 2;
        let clipPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        let linePath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        
        ctx.addPath(clipPath)
        ctx.setFillColor(fillColor.cgColor)
        ctx.closePath()
        ctx.fillPath()
        
        ctx.addPath(linePath)
        ctx.strokePath()
        
        ctx.restoreGState()
    }
    
}
