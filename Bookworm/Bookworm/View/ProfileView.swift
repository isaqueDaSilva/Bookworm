//
//  ProfileView.swift
//  Bookworm
//
//  Created by Isaque da Silva on 19/01/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Description(
                            title: "Name",
                            description: "usernametest@icloud.com",
                            primaryFont: .title3,
                            secondaryFont: .subheadline
                        )
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
            .navigationTitle("Username")
        }
    }
}

#Preview {
    ProfileView()
}
