//
//  Cover.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

struct Cover: View {
    let title: String
    let author: String
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "book.fill")
                .font(.system(size: 40))
                .foregroundStyle(.blue.gradient)
                .padding(.bottom, 5)
            Text(title)
                .font(.title)
                .fontWeight(.heavy)
                .fontDesign(.serif)
            Text(author)
                .font(.headline)
                .bold()
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .frame(width: 135, height: 180)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color(.systemGray3))
        )
    }
}

#Preview {
    Cover(title: "Hary Potter", author: "J.K Rowlling")
}
