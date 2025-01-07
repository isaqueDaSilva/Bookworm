//
//  NavigationStackButtonStyle.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//


import SwiftUI

struct NavigationStackButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(0.9)
    }
}

extension View {
    func navigationStackButtonStyle() -> some View {
        buttonStyle(NavigationStackButtonStyle())
    }
}