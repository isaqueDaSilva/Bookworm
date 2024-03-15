//
//  Color+Extensions.swift
//  Bookworm
//
//  Created by Isaque da Silva on 08/03/24.
//

import SwiftUI

extension Color {
    static var listLightGray = Color(CGColor(red: 246, green: 240, blue: 240, alpha: 0))
}

extension Color {
    /// Defines an outline on the book cover
    /// with a specific color indicating whether it was voted well or badly.
    /// - Parameter book: The book that will receive the outline on its cover.
    /// - Returns: Returns a specific color depending on its rating.
    static func overlayColor(_ book: Book) -> Color {
        if book.isFinished {
            
            switch Int(book.rating) {
            case 1...2:
                return .red
            case 3...4:
                return .orange
            case 5:
                return .green
            default:
                return .primary
            }
        } else {
            return .primary
        }
    }
}
