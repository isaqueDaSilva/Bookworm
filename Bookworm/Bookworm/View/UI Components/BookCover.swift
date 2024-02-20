//
//  BookCover.swift
//  Bookworm
//
//  Created by Isaque da Silva on 21/01/24.
//

import SwiftUI

struct BookCover: View {
    let width: CGFloat
    let height: CGFloat
    let customText: String
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.secondary)
            
            VStack {
                Image(systemName: "book.fill")
                    .font(.largeTitle)
                    .padding(.bottom, 5)
                Text(customText)
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(.primary)
            .padding()
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    BookCover(width: 90, height: 120, customText: "Teste 123")
}
