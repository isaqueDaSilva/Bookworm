//
//  InformationLabel.swift
//  Bookworm
//
//  Created by Isaque da Silva on 21/01/24.
//

import SwiftUI

struct InformationLabel: View {
    let informationTitle: String
    let informationDescription: String
    
    var body: some View {
        HStack {
            Text(informationTitle)
                .font(.body)
                .bold()
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text(informationDescription)
                .font(.body)
                .bold()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    InformationLabel(informationTitle: "Title Exemple", informationDescription: "Description Exemple")
        .padding()
}
