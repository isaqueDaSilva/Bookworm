//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        #if os(iOS)
        BookwormIOSScene()
        #endif
    }
}
