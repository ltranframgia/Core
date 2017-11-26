//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import Foundation
import UIKit

struct AppInfo {

    static let version: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let build: String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
}

struct Device {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}
