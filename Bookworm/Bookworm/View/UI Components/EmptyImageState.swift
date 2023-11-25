//
//  EmptyImageState.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/11/23.
//

import SwiftUI

struct EmptyImageState: View {
    let systemName: String
    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 113))
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.black.opacity(0.15))
                    .frame(width: 150, height: 150)
            }
            .frame(width: 150, height: 150)
    }
}
