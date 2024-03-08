//
//  Cover.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

struct Cover: View {
    var coverImage: UIImage?
    let title: String
    
    var body: some View {
        Group {
            if let coverImage {
                Image(uiImage: coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 135, height: 180)
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
                .frame(width: 135, height: 180)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color(.systemGray3))
                )
                .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    Cover(coverImage: nil, title: "Hary Potter")
}
