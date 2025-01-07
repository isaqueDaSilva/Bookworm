//
//  HomeMenu.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//


import SwiftUI

extension HomeView {
    struct HomeMenu: View {
        @Binding var displayingMode: DisplayingMode
        
        var body: some View {
            Menu {
                Picker("Displaying Mode", selection: $displayingMode) {
                    ForEach(DisplayingMode.allCases, id: \.id) {
                        Label($0.rawValue, systemImage: $0.systemImageName)
                    }
                }
                .labelsHidden()
            } label: {
                Image(systemName: displayingMode.systemImageName)
                    .contentTransition(.interpolate)
            }
        }
    }
}

#Preview {
    HomeView.HomeMenu(displayingMode: .constant(.grid))
}
