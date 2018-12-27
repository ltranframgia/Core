//
//  Created by Henry Tran
//  Copyright © 2017 THL. All rights reserved.
//

import Foundation

// DateFormat
enum DateFormat: String {
    case yyyyssDash = "yyyy-MM-dd'T'HH:mm:ss"
    case ddmmSlash = "dd/MM/yyyy HH:mm"
    case ddMMyyyy = "dd/MM/yyyy"
    case yyyyMMddDash = "yyyy-MM-dd"
    case MMyyyy = "MM/yyyy"
    case yyyyssSSSZZZZZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    case yyyyMMddJp = "yyyy年MM月d日"
}

enum LocaleIdentifier: String {
    case enUSPOSIX = "en_US_POSIX"
}

//class Formatter: NSObject {
//    static let shared = Formatter()
//
//    let dateFormatter = DateFormatter()
//
//    private override init() {
//        super.init()
//        dateFormatter.timeZone = NSTimeZone.default
//        dateFormatter.locale = NSLocale(localeIdentifier: Constant.defaultDateLocale) as Locale!
//    }
//}

extension Date {

    // MARK: - Date
    static func convertDateToString(fromDate: Date?, format: DateFormat) -> String? {
        if let convertDate = fromDate {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone.default
            dateFormatter.locale = NSLocale(localeIdentifier: LocaleIdentifier.enUSPOSIX.rawValue) as Locale
            dateFormatter.dateFormat = format.rawValue
            return dateFormatter.string(from: convertDate)
        } else {
            return nil
        }
    }

    static func convertStringToDate(fromString: String?, format: DateFormat) -> Date? {
        if let dateString = fromString {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone.default
            dateFormatter.locale = NSLocale(localeIdentifier: LocaleIdentifier.enUSPOSIX.rawValue) as Locale
            dateFormatter.dateFormat = format.rawValue
            return dateFormatter.date(from: dateString)
        } else {
            return nil
        }
    }

    static func convertStringDateToString(fromString: String?, fromFormat: DateFormat, toFormat: DateFormat) -> String? {
        if let dateString = fromString {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone.default
            dateFormatter.locale = NSLocale(localeIdentifier: LocaleIdentifier.enUSPOSIX.rawValue) as Locale
            dateFormatter.dateFormat = fromFormat.rawValue
            guard let date = dateFormatter.date(from: dateString) else {
                return nil
            }
            dateFormatter.dateFormat = toFormat.rawValue
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }

}
