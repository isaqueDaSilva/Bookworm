//
//  LoginView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/02/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        NavigationStack {
            GeometryReader{ geo in
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "book.fill")
                        Text("Bookwork")
                    }
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .bold()
                    .foregroundStyle(Color(uiColor: .systemBlue))
                    .frame(height: geo.size.height / 4)
                    
                    VStack {
                        EntryField(
                            label: Text("Email"),
                            content: TextField("insert your email here", text: $email),
                            leadingAccessoryView: Image(systemName: "person")
                        )
                        .padding(.bottom, 20)
                        
                        EntryField(
                            label: Text("Password"),
                            content: SecureFieldWithToggle(title: "Insert your password here...", text: $password),
                            leadingAccessoryView: Image(systemName: "key")
                        )
                    }
                    .frame(height: geo.size.height / 4)
                    .padding(.bottom, 20)
                    
                    Button {
                        
                    } label: {
                        Text("Login")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(minHeight: 54, alignment: .center)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(Color(uiColor: .systemBlue))
                            }
                        
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack(spacing: 0) {
                            Text("Don't have an account?")
                            Button("Create Account") {
                                
                            }
                        }
                        .font(.subheadline)
                        .bold()
                    }
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
