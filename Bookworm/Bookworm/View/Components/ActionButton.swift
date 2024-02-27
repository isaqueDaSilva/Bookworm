//
//  ActionButton.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    var isLoadingState: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                if isLoadingState {
                    ProgressView()
                } else {
                    Text(title)
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: 54, alignment: .center)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color(uiColor: .systemBlue))
            }
            
        }
        .buttonStyle(.plain)
    }
}
