//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Isaque da Silva on 31/08/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    static let manager = BooksManager(url: FileManager.documentyDirectory.appending(path: "SavedBooks"))
    @StateObject var dataManager = BooksData(manager: manager)
    var body: some Scene {
        WindowGroup {
            BooksView()
                .environmentObject(dataManager)
        }
    }
}
