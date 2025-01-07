//
//  DisplayingMode.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

extension HomeView {
    enum DisplayingMode: String, CaseIterable, Identifiable {
        case grid = "Grid"
        case list = "List"
        
        var systemImageName: String {
            switch self {
            case .grid:
                Icons.grid.rawValue
            case .list:
                Icons.list.rawValue
            }
        }
        
        var id: Self { self }
    }
}
