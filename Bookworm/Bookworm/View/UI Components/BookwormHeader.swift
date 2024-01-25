//
//  BookwormHeader.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/01/24.
//

import SwiftUI

struct BookwormHeader: View {
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "book")
            Text("Bookworm")
        }
        .font(.largeTitle)
        .bold()
    }
}

#Preview {
    BookwormHeader()
}
