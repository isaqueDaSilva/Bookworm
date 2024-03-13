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
    private var onImage = Image(systemName: "star.fill")
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
    
    /// Returns a filled or unfilled star icon depending on the rating value..
    /// - Parameter numeber: TThe maximum value for rating.
    /// - Returns: Returns a filled or unfilled SF Symbol `star` icon depending on the rating value
    private func image(for numeber: Int) -> Image {
        if numeber > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    /// Creates the Rating View
    /// - Parameter rating: An association with an Int value that will determine the number of stars that will be displayed with padding or not.
    init(rating: Binding<Int>) {
        _rating = rating
    }
}

#Preview {
    RatingStars(rating: .constant(3))
}


