//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    let manager = BooksMananger()
    var body: some Scene {
        WindowGroup {
            BooksView(manager: manager)
        }
    }
}
