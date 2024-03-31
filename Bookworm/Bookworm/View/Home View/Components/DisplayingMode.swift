//
//  DisplayingMode.swift
//  Bookworm
//
//  Created by Isaque da Silva on 30/03/24.
//

import Foundation

extension HomeView {
    enum DisplayingMode: String, CaseIterable, Identifiable {
        case icons = "Icons"
        case list = "List"
        
        var systemImageName: String {
            switch self {
            case .icons:
                Icons.grid.rawValue
            case .list:
                Icons.list.rawValue
            }
        }
        
        var id: Self { self }
    }
}
