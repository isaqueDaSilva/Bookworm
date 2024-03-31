//
//  RatingStar.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

/// A view for star-based reviews.
struct RatingStars: View {
    // MARK: - View Properties
    
    @Binding var rating: Int
    
    private var label = ""
    private var maximumRating = 5
    private var offImage: Image?
    private var onImage = Image(systemName: Icons.star.rawValue)
    private var offColor = Color.gray
    private var onColor = Color.yellow
    
    // MARK: - View
    var body: some View {
        HStack {
            ForEach(1...maximumRating, id: \.self) { number in
                image(for: number)
                    .foregroundStyle(number > rating ? offColor : onColor)
                    .onTapGesture { rating = number }
            }
        }
    }
    
    private func image(for numeber: Int) -> Image {
        if numeber > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    init(rating: Binding<Int>) {
        _rating = rating
    }
}

#Preview {
    RatingStars(rating: .constant(3))
}


