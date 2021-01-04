//
//  LabeledCardArea.swift
//  Cooperation
//
//  Created by Susan Jensen on 1/4/21.
//  Copyright © 2021 Personal. All rights reserved.
//

import UIKit

class LabeledCardArea: UIView {


    public var numberOfLines: Int = 1
    public var cardBackgroundColor: UIColor = UIColor.white { didSet { setNeedsDisplay(); setNeedsLayout() } }
    public var cardText: String = "temp"
    public var lineWidth = 1
    lazy private var centerNumberLabel: UILabel = createLabel()
    public var size = CGSize()
    
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.init(name: "Marker Felt", size: fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font!)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, .font: font!])
    }
        
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        addSubview(label)
        return label
    }

    private func configureCenterLabel(_ label: UILabel) {
        label.attributedText = centerString
        label.textColor = UIColor.black
       // label.frame.size = CGSize.zero
        label.frame.size = size
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
    }
    
    private var centerString: NSAttributedString {
        return centeredAttributedString(cardText, fontSize: centerFontSize)
    }
    
        
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCenterLabel(centerNumberLabel)
        centerNumberLabel.center = bounds.origin.offsetBy(dx: midpointX , dy: midpointY)
    }

    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundRect.addClip() // ignore the area outside of pic
        cardBackgroundColor = cardBackgroundColor.withAlphaComponent(0.3)
        cardBackgroundColor.setFill()
        roundRect.fill()
        UIColor.black.setStroke()
        roundRect.lineWidth = CGFloat(lineWidth)
        roundRect.setLineDash([2,3], count: 2, phase: 3)
        roundRect.stroke()
    }
}

extension LabeledCardArea {
    private struct SizeRatio {
        static let centerFontSizeToBoundsHeight: CGFloat = 0.16
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * 0.06
    }

    private var midpointX: CGFloat{
        return bounds.size.width * 0.5
    }
    private var midpointY: CGFloat{
        return bounds.size.height * 0.5
    }

    private var centerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.centerFontSizeToBoundsHeight
    }
}
