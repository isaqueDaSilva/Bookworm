//
//  ContentViewModel.swift
//  Bookworms
//
//  Created by Isaque da Silva on 26/08/23.
//

import Foundation
import SwiftUI

extension ContentView {
    class ContentViewModel: ObservableObject {
        @Published var showingAddNewBook = false
        
        func textColor(_ rating: Int16) -> Color {
            var color: Color = .green
            if rating <= 2 {
                color = .red
            } else if rating > 2 && rating < 5 {
                color = .orange
            } else if rating == 5 {
                color = .green
            }
            return color
        }
    }
}
