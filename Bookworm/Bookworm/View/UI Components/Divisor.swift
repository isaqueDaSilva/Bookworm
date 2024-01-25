//
//  Divisor.swift
//  Bookworm
//
//  Created by Isaque da Silva on 22/01/24.
//

import SwiftUI

struct Divisor: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 2)
            .foregroundStyle(.primary)
            .padding([.horizontal, .bottom])
    }
}

#Preview {
    Divisor()
}
