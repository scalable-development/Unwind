//
//  BubblesView.swift
//  Unwind
//
//  Created by Rahel Lüthy on 27.09.18.
//  Copyright © 2018 Scalable. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable
class BubblesView: UIView {
    
    static let backgroundColor = UIColor(hex: 0x292A30)
    static let defaultBubbleColor = UIColor(hex: 0x4484D1)
    static let toggledBubbleColor = UIColor(hex: 0x747478)
    
    static let bubbleSize: CGFloat = 20
    
    struct BubbleCoordinates: Hashable {
        let columnIndex: Int
        let rowIndex: Int
    }
    
    struct BubbleConfig {
        let bubbleCountX: Int
        let bubbleCountY: Int
        let start: CGPoint
        func toBubbleCoordinates(_ screenLocation: CGPoint) -> BubbleCoordinates {
            let columnIndex = Int(floor((screenLocation.x - start.x) / BubblesView.bubbleSize))
            let rowIndex = Int(floor((screenLocation.y - start.y) / BubblesView.bubbleSize))
            return BubbleCoordinates(columnIndex: columnIndex, rowIndex: rowIndex)
        }
    }
    
    private let config: BubbleConfig
    private var toggled: Set<BubbleCoordinates> = Set<BubbleCoordinates>()
    private let hapticFeedbackGenerator =
        UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.light)
    
    
    fileprivate static func createBubbleConfig(_ rect: CGRect) -> BubbleConfig {
        let bubbleCountX = floor(rect.width / BubblesView.bubbleSize)
        let bubbleCountY = floor(rect.height / BubblesView.bubbleSize)
        return BubbleConfig(
            bubbleCountX: Int(bubbleCountX),
            bubbleCountY: Int(bubbleCountY),
            start: CGPoint(
                x: (rect.width - (bubbleCountX * BubblesView.bubbleSize)) / 2,
                y: (rect.height - (bubbleCountY * BubblesView.bubbleSize)) / 2
            )
        )
    }
    
    override init(frame: CGRect) {
        config = BubblesView.createBubbleConfig(frame)
        super.init(frame: frame)
        backgroundColor = BubblesView.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        config = BubblesView.createBubbleConfig(UIScreen.main.bounds)
        super.init(coder: aDecoder)
        backgroundColor = BubblesView.backgroundColor
    }
    
    override func draw(_ rect: CGRect) {
        for x in stride(from: 0, to: self.config.bubbleCountX, by: 1) {
            for y in stride(from: 0, to: self.config.bubbleCountY, by: 1) {
                let bubble = CGRect(
                    x: self.config.start.x + CGFloat(x) * BubblesView.bubbleSize,
                    y: self.config.start.y + CGFloat(y) * BubblesView.bubbleSize,
                    width: BubblesView.bubbleSize,
                    height: BubblesView.bubbleSize
                )
                let fillColor =
                    self.toggled.contains(BubbleCoordinates(columnIndex: x, rowIndex: y))
                        ? BubblesView.toggledBubbleColor
                        : BubblesView.defaultBubbleColor
                let bubbleView = BubbleView(frame: bubble, fillColor: fillColor)
                bubbleView.draw(bubble)
            }
        }
    }
    
    fileprivate func toggleTouched(_ touches: Set<UITouch>) {
        for touch in touches {
            hapticFeedbackGenerator.prepare()
            let location = touch.location(in: self)
            let coordinates = self.config.toBubbleCoordinates(location)
            if (!self.toggled.contains(coordinates)) {
                self.toggled.insert(coordinates)
                self.setNeedsDisplay()
                hapticFeedbackGenerator.impactOccurred()
                playSound()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        toggleTouched(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        toggleTouched(touches)
    }
    
    var player: AVAudioPlayer?
    fileprivate func playSound() {
        if let asset = NSDataAsset(name: "click") {
            do {
                player = try AVAudioPlayer(data:asset.data, fileTypeHint: "wav")
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

extension CGColor {
    class func colorWithHex(hex: Int) -> CGColor {
        return UIColor(hex: hex).cgColor
    }
}
