//
//  EntryFieldConfiguration.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/02/24.
//

import SwiftUI

struct EntryFieldStyleConfiguration {
    let label: Label
    let content: Content
    let leadingAccessoryView: LeadingAccessoryView
    
    struct Label: View {
        var underlyingView: AnyView
        var body: some View {
            underlyingView
        }
    }
    
    struct Content: View {
        var underlyingView: AnyView
        var body: some View {
            underlyingView
        }
    }
    
    struct LeadingAccessoryView: View {
        var underlyingView: AnyView
        var body: some View {
            underlyingView
        }
    }
}

