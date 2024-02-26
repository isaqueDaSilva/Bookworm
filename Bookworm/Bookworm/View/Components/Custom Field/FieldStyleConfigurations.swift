//
//  FieldStyleConfigurations.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/02/24.
//

import SwiftUI

struct DefaultEntryFieldStyle: EntryFieldStyle {
    func makeBody(_ configuration: EntryFieldStyleConfiguration) -> some View {
        DefaultEntryField(configuration: configuration)
    }
}
