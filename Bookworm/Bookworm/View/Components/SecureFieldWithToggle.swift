//
//  SecureFieldWithToggle.swift
//  Bookworm
//
//  Created by Isaque da Silva on 26/02/24.
//

import SwiftUI

struct SecureFieldWithToggle: View {
    var title: String
    @Binding var text: String
    @State private var isHiddenSecureText = true
    var body: some View {
        HStack {
            if isHiddenSecureText {
                SecureField(title, text: $text)
            } else {
                TextField(title, text: $text)
            }
            
            Button {
                withAnimation(.easeInOut) {
                    isHiddenSecureText.toggle()
                        
                }
            } label: {
                Image(systemName: isHiddenSecureText ? "eye.slash" : "eye")
                    .foregroundStyle(Color(uiColor: .systemBlue))
                    .padding(.horizontal)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    SecureFieldWithToggle(title: "Email", text: .constant(""))
}
