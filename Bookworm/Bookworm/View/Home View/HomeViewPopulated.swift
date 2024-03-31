//
//  HomeViewPopulated.swift
//  Bookworm
//
//  Created by Isaque da Silva on 30/03/24.
//

import SwiftUI

extension HomeView {
    @ViewBuilder
    func HomeViewPopulated() -> some View {
        Group {
            switch displayingMode {
            case .icons:
                GridHomeView()
            case .list:
                ListHomeView()
            }
        }
    }
}

#Preview {
    HomeView(storage: .preview)
}
