//
//  CreateAccountView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 22/01/24.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                BookwormHeader()
                    .padding(.bottom, 5)
                
                Text("Register to manage all the books you read.")
                    .font(.headline)
                    .bold()
                    .foregroundStyle(.secondary)
                    .padding(.bottom)
                
                FieldComponent(
                    TextField("Insert your name here...", text: $name)
                )
                
                FieldComponent(
                    TextField("Insert your name here...", text: $name)
                )
                
                FieldComponent(
                    TextField("Insert your name here...", text: $name)
                )
                
                FieldComponent(
                    TextField("Insert your name here...", text: $name)
                )
                
                FieldComponent(
                    TextField("Insert your name here...", text: $name)
                )
                
                ActionButton(title: "Create Account") { }
            }
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CreateAccountView()
}
