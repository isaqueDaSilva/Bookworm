//
//  FieldStyles.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/02/24.
//

import SwiftUI

struct DefaultEntryField: View {
    let configuration: EntryFieldStyleConfiguration
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 4) {
                configuration.label
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack(alignment: .center, spacing: 8) {
                    Spacer(minLength: 8)
                    
                    configuration.leadingAccessoryView
                        .opacity(0.5)
                    
                    configuration.content
                }
                .frame(minHeight: 54, alignment: .center)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}
