//
//  ImageView.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

@IBDesignable class XImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
}
