//
//  LoginView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 22/01/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                BookwormHeader()
                .padding(.bottom)
                
                FieldComponent(
                    TextField("Insert your email here...", text: $email)
                    
                )
                
                FieldComponent(
                    SecureField("Insert your password here...", text: $password)
                )
                
                HStack(alignment: .center) {
                    Text("No Account?")
                        .font(.headline.bold())
                    Button("Create Account") { }
                }
                .padding(.top, 5)
                
                ActionButton(title: "Login") { }
            }

        }
    }
}

#Preview {
    LoginView()
}
