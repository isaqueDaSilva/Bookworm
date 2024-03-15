//
//  iOSScene.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

/// Display a specific scene for iOS devices
struct iOSScene: Scene {
    private var storage: Storage
    
    var body: some Scene {
        WindowGroup {
            HomeView(storage: storage)
        }
    }
    
    /// Initializes a scene for iOS Devices
    /// - Parameter storage: The type that contains the default container and viewContext types, of Core Data.
    init(storage: Storage) {
        self.storage = storage
    }
}
