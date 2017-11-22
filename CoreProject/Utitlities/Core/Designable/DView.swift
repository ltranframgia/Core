//
//  View.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

@IBDesignable class XView: UIView, XCornerDrawable {

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

    @IBInspectable var topLeftCorner: Bool = false {
        didSet {
            if self.topLeftCorner == true {
                self.corners.update(with: UIRectCorner.topLeft)
            } else {
                self.corners.remove(UIRectCorner.topLeft)
            }

            self.setNeedsDisplay()
        }
    }

    @IBInspectable var bottomLeftCorner: Bool = false {
        didSet {
            if self.bottomLeftCorner == true {
                self.corners.update(with: UIRectCorner.bottomLeft)
            } else {
                self.corners.remove(UIRectCorner.bottomLeft)
            }
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var topRightCorner: Bool = false {
        didSet {
            if self.topRightCorner == true {
                self.corners.update(with: UIRectCorner.topRight)
            } else {
                self.corners.remove(UIRectCorner.topRight)
            }

            self.setNeedsDisplay()
        }
    }

    @IBInspectable var bottomRightCorner: Bool = false {
        didSet {
            if self.bottomRightCorner == true {
                self.corners.update(with: UIRectCorner.bottomRight)
            } else {
                self.corners.remove(UIRectCorner.bottomRight)
            }
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
        if cornerRadius > 0 {
            self.drawBackground(corners: self.corners, bgColor: self.bgColor, cornerRadii: sizeCornerRadii)
        }

        // draw border width
        self.borderShapeLayer?.removeFromSuperlayer()
        if self.borderWidth > 0 {
            self.borderShapeLayer = self.createBorderLayer(corners: self.corners, borderColor: self.borderColor, lineWidth: self.borderWidth, cornerRadii: sizeCornerRadii)
        }
    }
}
