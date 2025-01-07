//
//  Description.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import SwiftUI

struct Description: View {
    let title: String
    let author: String
    
    var body: some View {
        Group {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .bold()
                .multilineTextAlignment(.leading)
            
            Text(author)
                .font(.headline)
                .bold()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    Description(title: "Dummy", author: "Dummy Author")
}
