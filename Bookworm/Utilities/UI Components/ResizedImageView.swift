//
//  ResizedImageView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import SwiftUI

struct ResizedImageView<Content: View>: View {
    var image: UIImage?
    var size: CGSize
    
    @ViewBuilder var content: (Image) -> Content
    
    @State private var resizedImage: Image?
    
    var body: some View {
        Group {
            if let resizedImage {
                content(resizedImage)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            guard resizedImage == nil else { return }
            downsizeImage(image)
        }
        .onChange(of: image) { oldValue, newValue in
            guard newValue != oldValue else { return }
            downsizeImage(image)
        }
    }
    
    private func downsizeImage(_ image: UIImage?) {
        guard let image else { return }
        
        let aspectSize = image.size.aspectToFit(size)
        
        Task.detached(priority: .high) {
            let renderer = UIGraphicsImageRenderer(size: aspectSize)
            
            let resizedImage = renderer.image { context in
                image.draw(in: .init(origin: .zero, size: aspectSize))
            }
            
            await MainActor.run {
                self.resizedImage = .init(uiImage: resizedImage)
            }
        }
    }
}
