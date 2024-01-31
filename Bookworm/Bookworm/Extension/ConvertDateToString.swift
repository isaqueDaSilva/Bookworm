//
//  ConvertDateToString.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/01/24.
//

import Foundation

extension Date {
    func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        return formatter.string(from: date)
    }
}
