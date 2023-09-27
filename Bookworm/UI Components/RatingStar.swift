//
//  RatingStar.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

struct RatingStars: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1...maximumRating, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Rating")
        .accessibilityValue("\(rating) \(rating == 1 ? "Star" : "Stars")")
        .accessibilityAdjustableAction { action in
            switch action {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }
    
    func image(for numeber: Int) -> Image {
        if numeber > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}
