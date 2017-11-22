//
//  String+Ext.swift
//  ToeicCoach
//
//  Created by Henry Tran on 10/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

public typealias AttributedKeyDictionary = [NSAttributedStringKey : Any]

extension String {

    var localized: String {
        return self.localizedWithComment(comment: "")
    }

    func localizedWithComment(comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }

    func sizeToFitWidth(_ width: CGFloat, attributes: AttributedKeyDictionary) -> CGSize {

        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)

        let fitRect = self.boundingRect(with: constraintRect, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: attributes, context: nil)
        return CGSize(width: ceil(fitRect.size.width), height: ceil(fitRect.size.height))
    }
}
