//
//  FileManagerExtentionForTest.swift
//  Bookworm_Tests
//
//  Created by Isaque da Silva on 02/12/23.
//

import Foundation
import XCTest

extension FileManager {
    static var documentsDirectoryForTests: URL {
        let fileManager = FileManager.default
        let directory = fileManager.temporaryDirectory
        let fileName = UUID().uuidString
        let fileURL = directory.appending(path: fileName)
        
        if fileManager.fileExists(atPath: fileURL.path()) {
            try? fileManager.removeItem(at: fileURL)
        }
        
        return fileURL
    }
}
