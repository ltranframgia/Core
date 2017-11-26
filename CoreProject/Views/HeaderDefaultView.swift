//
//  HeaderDefaultView.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable class HeaderDefaultView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.contentView.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.contentView.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.contentView.borderColor = borderColor
        }
    }

    @IBInspectable var bgColor: UIColor = UIColor.clear {
        didSet {
            self.contentView.bgColor = bgColor
        }
    }

    @IBInspectable var topLeftCorner: Bool = false {
        didSet {
            self.contentView.topLeftCorner = topLeftCorner
        }
    }

    @IBInspectable var bottomLeftCorner: Bool = false {
        didSet {
            self.contentView.bottomLeftCorner = bottomLeftCorner
        }
    }

    @IBInspectable var topRightCorner: Bool = false {
        didSet {
            self.contentView.topRightCorner = topRightCorner
        }
    }

    @IBInspectable var bottomRightCorner: Bool = false {
        didSet {
            self.contentView.bottomRightCorner = bottomRightCorner
        }
    }

    @IBOutlet private var contentView: XView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var actionButton: XButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initView()
    }

    private func initView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        if let _contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            self.addSubview(_contentView)
            _contentView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.snp.top).offset(0)
                make.bottom.equalTo(self.snp.bottom).offset(0)
                make.trailing.equalTo(self.snp.trailing).offset(0)
                make.leading.equalTo(self.snp.leading).offset(0)
            })
        }
    }

}
