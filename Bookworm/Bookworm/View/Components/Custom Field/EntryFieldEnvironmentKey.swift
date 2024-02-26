//
//  EntryFieldEnvironmentKey.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/02/24.
//

import SwiftUI

struct EntryFieldEnvironmentKey: EnvironmentKey {
    static let defaultValue: any EntryFieldStyle = DefaultEntryFieldStyle()
}

extension EnvironmentValues {
    var entryFieldStyle: any EntryFieldStyle {
        get { self[EntryFieldEnvironmentKey.self] }
        set { self[EntryFieldEnvironmentKey.self] = newValue }
    }
}

extension View {
    // Makes a new style for the EntryField.
    func entryFieldStyle(_ style: some EntryFieldStyle) -> some View {
        environment(\.entryFieldStyle, style)
    }
}
