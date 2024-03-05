//
//  iOSScene.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/02/24.
//

import SwiftUI

struct iOSScene: Scene {
    private var storage: Storage
    
    var body: some Scene {
        WindowGroup {
            HomeView(storage: storage)
        }
    }
    
    init(storage: Storage) {
        self.storage = storage
    }
}
