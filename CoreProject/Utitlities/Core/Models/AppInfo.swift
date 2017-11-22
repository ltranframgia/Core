//
//  AppInfo.swift
//  CoreProject
//
//  Created by Henry Tran on 11/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

struct AppInfo {

    static let version: String? = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let build: String? = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
}
