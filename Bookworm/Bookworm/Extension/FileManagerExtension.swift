//
//  FileManagerExtension.swift
//  Bookworm
//
//  Created by Isaque da Silva on 18/11/23.
//

import Foundation

extension FileManager {
    static var documentyDirectory: URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    static var documentsDirectoryForTests: URL {
        FileManager.default.temporaryDirectory
    }
}
