//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import SwiftUI

@main
struct BookwormApp: App {
    private var storageController = Storage()
    
    var body: some Scene {
        iOSScene(storage: storageController)
    }
}
