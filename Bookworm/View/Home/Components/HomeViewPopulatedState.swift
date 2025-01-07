//
//  HomeViewPopulatedState.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import SwiftUI

extension HomeView {
    struct HomeViewPopulatedState: View {
        @Environment(ViewModel.self) private var viewModel
        @Binding var displayingMode: DisplayingMode
        
        var body: some View {
            Group {
                switch displayingMode {
                case .grid:
                    GridHomeView()
                case .list:
                    ListHomeView()
                }
            }
            .environment(viewModel)
        }
    }
}

#Preview("Grid Style") {
    HomeView.HomeViewPopulatedState(displayingMode: .constant(.grid))
        .environment(HomeView.ViewModel(storage: .preview))
}

#Preview("List Style") {
    HomeView.HomeViewPopulatedState(displayingMode: .constant(.list))
        .environment(HomeView.ViewModel(storage: .preview))
}
