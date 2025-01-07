//
//  RatingStars.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/3/25.
//


import SwiftUI

/// A view for star-based reviews.
struct RatingStars: View {
    // MARK: - View Properties
    
    @Binding var rating: Int
    
    private var offColor = Color.gray
    private var onColor = Color.yellow
    
    // MARK: - View
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { number in
                Icons.star.systemImage
                    .foregroundStyle(number > rating ? offColor : onColor)
                    .onTapGesture { rating = number }
            }
        }
    }
    
    init(rating: Binding<Int>) {
        _rating = rating
    }
}

#Preview {
    RatingStars(rating: .constant(3))
}
