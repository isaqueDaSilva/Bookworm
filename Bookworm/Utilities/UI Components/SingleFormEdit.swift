//
//  SingleFormEdit.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

struct SingleFormEdit: View {
    @Binding var name: String
    
    var body: some View {
        Form {
            TextField(
                "Add the author name here",
                text: $name
            )
        }
    }
}

#Preview {
    SingleFormEdit(name: .constant(""))
}
