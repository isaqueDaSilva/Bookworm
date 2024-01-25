//
//  Tab.swift
//  Bookworm
//
//  Created by Isaque da Silva on 17/01/24.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "Home"
    case profile = "Profile"
    
    var systemImage : String {
        switch self {
        case .home:
            return "book"
        case .profile:
            return "person"
        }
    }
}
