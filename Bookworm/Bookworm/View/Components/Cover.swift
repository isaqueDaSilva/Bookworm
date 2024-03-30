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
    
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Group {
            if let coverImage {
                Image(uiImage: coverImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                VStack(alignment: .center) {
                    GeometryReader { geo in
                        VStack {
                            Icons.bookFill.systemImage
                                .font(.system(size: geo.size.width * 0.6))
                                .foregroundStyle(.blue.gradient)
                                .ignoresSafeArea()
                            Text(title)
                                .font(.system(size: geo.size.width * 0.2))
                                .fontWeight(.heavy)
                                .fontDesign(.serif)
                                .lineLimit(2)
                        }
                        .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
                    }
                }
                .multilineTextAlignment(.center)
                .frame(width: width, height: height)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color(.systemGray3))
                )
            }
        }
    }
    
    init(
        coverImage: UIImage? = nil,
        title: String,
        width: CGFloat = 150,
        height: CGFloat = 200
    ) {
        self.coverImage = coverImage
        self.title = title
        self.width = width
        self.height = height
    }
}

#Preview {
    VStack {
        Cover(title: "Harry Potter")
        
        Cover(title: "Harry Potter", width: 75, height: 100)
        
        Cover(coverImage: UIImage(systemName: Icons.plusCircle.rawValue), title: "Hary Potter")
    }
}
