//
//  Date+Extensions.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import Foundation

extension Date {
    /// Transform a Date type in a String representation of the raw value.
    /// - Returns: Returns a String value representation about the Date type.
    func dateString() -> String {
        let currentLocale = Locale.current
        let template = "YYYY/MM/dd"
        let dateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: currentLocale) ?? template
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: self)
    }
}
