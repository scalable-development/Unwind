//
//  BubblesView.swift
//  Unwind
//
//  Created by Rahel Lüthy on 27.09.18.
//  Copyright © 2018 Scalable. All rights reserved.
//

import UIKit

@IBDesignable
class BubblesView: UIView {
    
    let bubbleSize: CGFloat = 10

    override func draw(_ rect: CGRect) {
        
        let bubbleCountX = floor(rect.width / bubbleSize)
        let bubbleCountY = floor(rect.height / bubbleSize)
        
        let startX = (rect.width - (bubbleCountX * bubbleSize)) / 2
        let startY = (rect.height - (bubbleCountY * bubbleSize)) / 2
        
        for x in stride(from: 0, to: bubbleCountX, by: 1) {
            for y in stride(from: 0, to: bubbleCountY, by: 1) {
                let cell = CGRect(
                    x: startX + x * bubbleSize,
                    y: startY + y * bubbleSize,
                    width: bubbleSize,
                    height: bubbleSize
                )
                UIColor.purple.setFill()
                UIRectFill(cell)
                UIColor.white.setStroke()
                UIRectFrame(cell)
            }
        }
    }

}
