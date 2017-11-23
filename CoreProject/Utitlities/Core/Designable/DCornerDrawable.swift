//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

protocol XCornerDrawable {

    func drawBackground(corners: UIRectCorner, bgColor: UIColor?, cornerRadii: CGSize)

    func createBorderLayer(corners: UIRectCorner, borderColor: UIColor?, lineWidth: CGFloat, cornerRadii: CGSize) -> CAShapeLayer?

    func drawHighlight(corners: UIRectCorner, cornerRadii: CGSize)
}

extension XCornerDrawable where Self: UIView {

    func drawBackground(corners: UIRectCorner, bgColor: UIColor?, cornerRadii: CGSize) {

        // context
        if let context = UIGraphicsGetCurrentContext() {

            // save context
            context.saveGState()
            // bg
            let bgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
            bgPath.close()
            bgColor?.setFill()
            bgPath.fill()

            // restore
            context.restoreGState()
        }
    }

    func createBorderLayer(corners: UIRectCorner, borderColor: UIColor?, lineWidth: CGFloat, cornerRadii: CGSize) -> CAShapeLayer? {

        // path
        // let roundedRect = self.bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        let bgPathSkoke = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)

        // CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bgPathSkoke.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = borderColor?.cgColor
        shapeLayer.lineWidth = lineWidth
        self.layer.addSublayer(shapeLayer)

        return shapeLayer
    }

    func drawHighlight(corners: UIRectCorner, cornerRadii: CGSize) {

        // context
        if let context = UIGraphicsGetCurrentContext() {

            // save context
            context.saveGState()

            // highlightColor
            let highlightColor = UIColor.white.withAlphaComponent(0.3)

            // path
            let bgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
            highlightColor.setFill()
            bgPath.fill()

            // restore
            context.restoreGState()
        }
    }
}
