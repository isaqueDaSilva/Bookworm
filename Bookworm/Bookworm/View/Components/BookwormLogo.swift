//
//  BookwormLogo.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import SwiftUI

struct BookwormLogo: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: "book.fill")
            Text("Bookworm")
        }
        .font(.system(size: 40))
        .fontWeight(.heavy)
        .bold()
        .foregroundStyle(Color(uiColor: .systemBlue))
    }
}
