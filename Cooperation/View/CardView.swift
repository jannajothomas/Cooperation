//
//  Card.swift
//  Cooperation
//
//  Created by Janna Thomas on 12/8/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class CardView: UIView {
    public var hand = Int()
    public var card = Int()
   
    /*Color of a the number on a visible card*/
    public var col: UIColor = UIColor.white
           { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    /*Outline of a card that changes color when a hint is given*/
    @IBInspectable var hasColorHint: Bool = false {
        didSet{
            if(hasColorHint){
                 cardOutlineColor = col
             }else{
                 cardOutlineColor = UIColor.black
             }
            setNeedsDisplay(); setNeedsLayout()
        }
    }
    
    /*Number displayed on a face up card*/
    public var num = Int()
        { didSet { setNeedsDisplay(); setNeedsLayout() } }
   
    @IBInspectable var isFaceUp: Bool = false
        { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    @IBInspectable var isSelected: Bool = false
        { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    /*Adds small visible number to card*/
    @IBInspectable var hasNumberHint: Bool = false
        { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    /* card can be in one of four locations.  If the card is located in a hand, then the hand and card information is valid.  It starts as -1, and will be reset to -1 after it moves out of the hand. This is primaily used to facilitate the animation.   */
    public var location = "deck"

    
    public var cardBackgroundColor: UIColor = UIColor.white { didSet { setNeedsDisplay(); setNeedsLayout() } }
    public var cardOutlineColor: UIColor = UIColor.black { didSet { setNeedsDisplay(); setNeedsLayout() } }
    

    var centerNumberSize: CGFloat = SizeRatio.faceCardImageSizeToBoundsSize { didSet { setNeedsDisplay() } }
    var lineWidth = 1
    
    private func centeredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.init(name: "Marker Felt", size: fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, .font: font!])
    }
    
    lazy private var upperLefCornerLabel: UILabel = createLabel()
    lazy private var lowerRightCornerLabel: UILabel = createLabel()
    lazy private var centerNumberLabel: UILabel = createLabel()
    lazy private var cardHint: UILabel = createLabel()
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        addSubview(label)
        return label
    }
    
    private func configureConerLabel(_ label: UILabel) {
        if(num != 0){
            label.attributedText = cornerString
            label.textColor = col
            label.frame.size = CGSize.zero
            label.sizeToFit()
            label.isHidden = !isFaceUp
        }
        
    }
    
    private func configureCenterLabel(_ label: UILabel) {
        if(num != 0){
            label.attributedText = centerString
            label.textColor = col
                   label.frame.size = CGSize.zero
                   label.sizeToFit()
                   label.isHidden = !isFaceUp
        }
    }
    
    private func configureCardHint(_ label: UILabel) {
        if(hasNumberHint){
            label.attributedText = cornerString
        }else{
            label.text = ""
        }
        label.textColor = UIColor.black
        label.frame.size = CGSize.zero
        label.sizeToFit()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCenterLabel(centerNumberLabel)
        centerNumberLabel.center = bounds.origin.offsetBy(dx: midpointX , dy: midpointY)
        
        configureConerLabel(upperLefCornerLabel)
        upperLefCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        configureConerLabel(lowerRightCornerLabel)
        
        lowerRightCornerLabel.transform = CGAffineTransform.identity.translatedBy(
            x: lowerRightCornerLabel.bounds.size.width,
            y: lowerRightCornerLabel.bounds.size.height)
        
        lowerRightCornerLabel.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi)
        
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
        
        configureCardHint(cardHint)
        cardHint.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset - 23)
    }
    
    private var cornerString: NSAttributedString {
        return centeredAttributedString(String(num), fontSize: cornerFontSize)
    }
    
    private var centerString: NSAttributedString {
        return centeredAttributedString(String(num), fontSize: centerFontSize)
    }
    
    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundRect.addClip() // ignore the area outside of pic
        
        if num == 0{
                   cardBackgroundColor = cardBackgroundColor.withAlphaComponent(0.3)
               }
        
        if isFaceUp == true{
            cardBackgroundColor.setFill()
        }else{
            UIColor.gray.setFill()
        }
        
        roundRect.fill()

        
        
        cardOutlineColor.setStroke()
        if(isSelected){
            roundRect.lineWidth = CGFloat(10)
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 1
            layer.shadowOffset = .zero
            layer.shadowRadius = 10
            //roundRect.
        }else{
            roundRect.lineWidth = CGFloat(lineWidth)
            layer.shadowRadius = 0
        }
        roundRect.stroke()
        if isFaceUp{}
        else{ if let cardBackImage = UIImage(named: "cardback", in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                cardBackImage.draw(in: bounds)
            }}
    }
}

extension CardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.2
        static let centerFontSizeToBoundsHeight: CGFloat = 0.6
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    private var midpointX: CGFloat{
        return bounds.size.width * 0.5
    }
    private var midpointY: CGFloat{
        return bounds.size.height * 0.5
    }
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    private var centerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.centerFontSizeToBoundsHeight
    }
}

extension CGRect {
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
