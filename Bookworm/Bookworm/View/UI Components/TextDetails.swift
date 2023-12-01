//
//  TextDetails.swift
//  Bookworm
//
//  Created by Isaque da Silva on 24/11/23.
//

import SwiftUI

struct TextDetails: View {
    let title: String
    let description: String
    let displayInfo: Bool
    var displaySafariView: ((_ text: String) -> Void)? = nil
    var body: some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            
            HStack {
                Text(description)
                
                if displayInfo {
                    Button {
                        guard let displaySafariView = displaySafariView else { return }
                        displaySafariView(description)
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .foregroundStyle(.gray)
        }
    }
}
