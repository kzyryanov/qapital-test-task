//
//  DateHelper.swift
//  Qapital Activities
//
//  Created by Konstantin Zyrianov on 2021-09-15.
//

import Foundation

final class DateHelper {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ssxxx"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.locale = Locale.current
        return dateFormatter
    }()
    
    private init() {}
    
    /**
     Returns date from in ISO8601 standard (YYYY-MM-dd'T'HH:mm:ssxxx)
     - parameters:
     - string: String in ISO8601 standard YYYY-MM-dd'T'HH:mm:ssxxx
     
     - returns: A date representation of string.
     */
    static func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    /**
     Returns date string in ISO8601 standard (YYYY-MM-dd'T'HH:mm:ssxxx)
     - parameters:
     - date: The date to format
     
     - returns: Formatted string in ISO8601 standard
     */
    static func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    /**
     Returns date string in human readable format ('Today', 'Yesterday', '1 Nov, 2021')
     - parameters:
     - date: The date to format
     
     - returns: Formatted string, e.g. 'Today', 'Yesterday' or '1 Nov, 2021'
     */
    static func formattedString(from date: Date) -> String {
        return shortDateFormatter.string(from: date)
    }
}
