//
//  Cover.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

/// The representation of the cover of a book cover.
struct Cover: View {
    // If the book has a saved cover,
    // it will be displayed in place of the custom cover.
    var coverImage: UIImage?
    
    // Get's the title of Book.
    let title: String
    
    var body: some View {
        Group {
            if let coverImage {
                Image(uiImage: coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                VStack(alignment: .center) {
                    Icons.bookFill.systemImage
                        .font(.system(size: 40))
                        .foregroundStyle(.blue.gradient)
                        .padding(.bottom, 5)
                    
                    Text(title)
                        .font(.title)
                        .fontWeight(.heavy)
                        .fontDesign(.serif)
                }
                .multilineTextAlignment(.center)
                .frame(width: 150, height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color(.systemGray3))
                )
            }
        }
    }
}

#Preview {
    VStack {
        Cover(title: "Harry Potter")
        
        Cover(coverImage: UIImage(systemName: Icons.plus.rawValue), title: "Hary Potter")
    }
}
