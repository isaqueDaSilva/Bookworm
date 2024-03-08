//
//  Date+Extensions.swift
//  Bookworm
//
//  Created by Isaque da Silva on 08/03/24.
//

import Foundation

extension Date {
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY/MM/dd"
        
        return formatter.string(from: self)
    }
}
