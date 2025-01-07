//
//  AnnotationEdit.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/4/25.
//

import SwiftUI

struct AnnotationEdit: View {
    @Binding var title: String
    @Binding var commentDescription: String
    
    let lastUpdate: Date
    
    var body: some View {
        Form {
            Section {
                TextField("Insert the title here...", text: $title)
                TextField(
                    "Insrt the comment here...",
                    text: $commentDescription,
                    axis: .vertical
                )
                .lineLimit(10, reservesSpace: true)
            } footer: {
                Text("Last Modification: \(lastUpdate.dateString())")
            }
        }
    }
    
    init(
        title: Binding<String>,
        commentDescription: Binding<String>,
        lastUpdate: Date = .now
    ) {
        self._title = title
        self._commentDescription = commentDescription
        self.lastUpdate = lastUpdate
    }
}

#Preview("Empty properties") {
    AnnotationEdit(
        title: .constant(""),
        commentDescription: .constant(""),
        lastUpdate: .now
    )
}

#Preview("Non Empty properties") {
    AnnotationEdit(
        title: .constant("Harry Potter"),
        commentDescription: .constant("Good Book"),
        lastUpdate: .now
    )
}
