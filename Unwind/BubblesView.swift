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
    
    static let bubbleSize: CGFloat = 20
    
    struct BubbleConfig {
        let bubbleCountX: CGFloat
        let bubbleCountY: CGFloat
        let start: CGPoint
    }
    
    private let config: BubbleConfig
    
    fileprivate static func createBubbleConfig(_ rect: CGRect) -> BubbleConfig {
        let bubbleCountX = floor(rect.width / BubblesView.bubbleSize)
        let bubbleCountY = floor(rect.height / BubblesView.bubbleSize)
        return BubbleConfig(
            bubbleCountX: bubbleCountX,
            bubbleCountY: bubbleCountY,
            start: CGPoint(
                x: (rect.width - (bubbleCountX * BubblesView.bubbleSize)) / 2,
                y: (rect.height - (bubbleCountY * BubblesView.bubbleSize)) / 2
            )
        )
    }
    
    override init(frame: CGRect) {
        config = BubblesView.createBubbleConfig(frame)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        config = BubblesView.createBubbleConfig(UIScreen.main.bounds)
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        for x in stride(from: 0, to: self.config.bubbleCountX, by: 1) {
            for y in stride(from: 0, to: self.config.bubbleCountY, by: 1) {
                let cell = CGRect(
                    x: self.config.start.x + x * BubblesView.bubbleSize,
                    y: self.config.start.y + y * BubblesView.bubbleSize,
                    width: BubblesView.bubbleSize,
                    height: BubblesView.bubbleSize
                )
                UIColor.purple.setFill()
                UIRectFill(cell)
                UIColor.white.setStroke()
                UIRectFrame(cell)
            }
        }
    }

}
