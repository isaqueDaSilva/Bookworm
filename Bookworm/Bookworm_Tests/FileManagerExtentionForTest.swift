//
//  FileManagerExtentionForTest.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 02/12/23.
//

import Foundation

extension FileManager {
    static var documentsDirectoryForTests: URL {
        FileManager.default.temporaryDirectory
    }
}
