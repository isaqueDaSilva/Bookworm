//
//  BookwormIOSScene.swift
//  Bookworm
//
//  Created by Isaque da Silva on 18/01/24.
//

import SwiftUI

struct Home: Scene {
    @StateObject private var manager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            if manager.user != nil {
                BooksView()
            } else {
                LoginView()
            }
        }
    }
}
