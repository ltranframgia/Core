//
//  Button.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

@IBDesignable class XButton: UIButton, XCornerDrawable {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var bgColor: UIColor = UIColor.clear {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var topCorner: Bool = false {
        didSet {
            if self.topCorner == true {
                self.corners.update(with: UIRectCorner.topLeft)
                self.corners.update(with: UIRectCorner.topRight)
            } else {
                self.corners.remove(UIRectCorner.topLeft)
                self.corners.remove(UIRectCorner.topRight)
            }

            self.setNeedsDisplay()
        }
    }

    @IBInspectable var bottomCorner: Bool = false {
        didSet {
            if self.bottomCorner == true {
                self.corners.update(with: UIRectCorner.bottomLeft)
                self.corners.update(with: UIRectCorner.bottomRight)
            } else {
                self.corners.remove(UIRectCorner.bottomLeft)
                self.corners.remove(UIRectCorner.bottomRight)
            }
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var isCustomHighlight: Bool = false

    override var isHighlighted: Bool {
        didSet {
            self.setNeedsDisplay()
        }
    }

    // MARK: - Variables
    private var corners: UIRectCorner = []
    private var borderShapeLayer: CAShapeLayer?

    // MARK: - DrawRect
    override func draw(_ rect: CGRect) {

        let sizeCornerRadii = CGSize(width: self.cornerRadius, height: self.cornerRadius)

        // draw bg corner
        if self.cornerRadius > 0 {
            self.drawBackground(corners: self.corners, bgColor: self.bgColor, cornerRadii: sizeCornerRadii)
        }

        // draw border width
        self.borderShapeLayer?.removeFromSuperlayer()
        if self.borderWidth > 0 {
            self.borderShapeLayer = self.createBorderLayer(corners: self.corners, borderColor: self.borderColor, lineWidth: self.borderWidth, cornerRadii: sizeCornerRadii)
        }

        if self.isHighlighted == true &&
            self.isCustomHighlight == true {
            self.drawHighlight(corners: self.corners, cornerRadii: sizeCornerRadii)
        }
    }

    // MARK: - Functions
}
