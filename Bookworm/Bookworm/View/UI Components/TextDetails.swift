//
//  TextDetails.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/11/23.
//

import SwiftUI

struct TextDetails: View {
    let title: String
    let description: String
    var body: some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            Text(description)
                .foregroundStyle(.gray)
        }
    }
}
