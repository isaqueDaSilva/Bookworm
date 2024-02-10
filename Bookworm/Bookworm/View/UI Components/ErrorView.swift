//
//  ErrorView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 08/02/24.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .padding()
            Text("Failed to load data, please try again.")
                .font(.headline)
                .bold()
        }
    }
}
