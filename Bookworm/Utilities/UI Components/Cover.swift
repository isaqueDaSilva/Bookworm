//
//  Cover.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
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
                ResizedImageView(
                    image: coverImage,
                    size: .init(width: width, height: height)
                ) { coverImage in
                    coverImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
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
        size: CGSize
    ) {
        self.coverImage = coverImage
        self.title = title
        self.width = size.width
        self.height = size.height
    }
}

#Preview {
    VStack {
        Cover(title: "Harry Potter", size: .coverFullSize)
        
        Cover(title: "Harry Potter", size: .coverMiniature)
        
        Cover(coverImage: UIImage(systemName: Icons.plusCircle.rawValue), title: "Hary Potter", size: .coverFullSize)
        
        Cover(coverImage: UIImage(systemName: Icons.plusCircle.rawValue), title: "Hary Potter", size: .coverMiniature)
    }
}
