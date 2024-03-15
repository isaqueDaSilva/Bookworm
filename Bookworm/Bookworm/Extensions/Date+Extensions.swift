//
//  Date+Extensions.swift
//  Bookworm
//
//  Created by Isaque da Silva on 08/03/24.
//

import Foundation

extension Date {
    /// Transform a Date type in a String representation of the raw value.
    /// - Returns: Returns a String value representation about the Date type.
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY/MM/dd"
        
        return formatter.string(from: self)
    }
}
