//
//  BookwormIOSScene.swift
//  Bookworm
//
//  Created by Isaque da Silva on 18/01/24.
//

import SwiftUI

struct BookwormIOSScene: Scene {
    var body: some Scene {
        WindowGroup {
            TabView {
                BooksHomeView()
                    .tag(Tab.home)
                    .tabItem {
                        Label(Tab.home.rawValue, systemImage: Tab.home.systemImage)
                    }
                
                ProfileView()
                    .tag(Tab.profile)
                    .tabItem {
                        Label(Tab.profile.rawValue, systemImage: Tab.profile.systemImage)
                    }
            }
        }
    }
}
