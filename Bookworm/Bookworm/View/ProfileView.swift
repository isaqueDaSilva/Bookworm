//
//  ProfileView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 19/01/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var isActive = false
    @State private var text = "Username"
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            Description(
                                title: text,
                                description: "usernametest@icloud.com",
                                primaryFont: .title3,
                                secondaryFont: .subheadline
                            )
                        }
                        Spacer()
                        Menu("Edit") {
                            Button {
                                alertWithTextField(
                                    title: "Edit Username",
                                    message: "Insert your new username in the session below",
                                    text: text,
                                    placeholder: "username",
                                    primaryActionTitle: "OK",
                                    secondaryActionTitle: "Cancel") { text in
                                        someAction(someText: text)
                                    }
                            } label: {
                                Label("Edit Username", systemImage: "pencil")
                            }
                        }
                    }
                }
                
                Section {
                    InformationLabel(
                        informationTitle: "Authors",
                        informationDescription: "3"
                    )
                }
                
                Section {
                    DestructiveButton(label: "Sign Out") { }
                }
                
                Section {
                    DestructiveButton(label: "Delete this account") { }
                }
            }
            .navigationTitle("Name")
        }
    }
    
    func someAction(someText: String) { 
        text = someText
    }
}

#Preview {
    ProfileView()
}
