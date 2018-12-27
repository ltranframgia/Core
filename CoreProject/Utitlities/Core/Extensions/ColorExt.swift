//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init?(hex: String) {

        // remove
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexColor = hexColor.replacingOccurrences(of: "#", with: "")

        // variables
        var rHex: CGFloat = 0.0
        var gHex: CGFloat = 0.0
        var bHex: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hexNumber: UInt64 = 0

        // scan
        if Scanner(string: hexColor).scanHexInt64(&hexNumber) {
            if hexColor.count == 6 {
                rHex = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
                gHex = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
                bHex = CGFloat(hexNumber & 0x0000FF) / 255.0
            } else if hexColor.count == 8 {
                rHex = CGFloat((hexNumber & 0xFF000000) >> 24) / 255
                gHex = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255
                bHex = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255
                alpha = CGFloat(hexNumber & 0x000000FF) / 255
            } else {
                return nil
            }
        } else {
            return nil
        }

        self.init(red: rHex, green: gHex, blue: bHex, alpha: alpha)
    }

}
