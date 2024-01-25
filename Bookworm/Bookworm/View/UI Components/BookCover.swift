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
                .foregroundStyle(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            Text(customText)
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.black)
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    BookCover(width: 90, height: 120, customText: "T")
}
