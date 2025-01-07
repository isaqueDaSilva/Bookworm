//
//  ImageSetter.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/6/25.
//

import Foundation
import SwiftUI
import PhotosUI
import Observation
import os.log

@Observable
@MainActor
final class ImageSetter {
    @ObservationIgnored
    private let logger = Logger(
        subsystem: "com.isaqueDaSilva.Bookworm",
        category: "ImageSetter"
    )
    
    var coverImage: UIImage? = nil
    var coverImageData: Data? = nil
    var pickerItemSelect: PhotosPickerItem? = nil {
        didSet {
            if let pickerItemSelect {
                getImage(pickerItemSelect)
            }
        }
    }
    
    private func getImage(_ pickerItemSelected: PhotosPickerItem) {
        Task {
            if let pickerItemSelect,
               let data = try? await pickerItemSelect.loadTransferable(type: Data.self) {
                if let image = UIImage(data: data) {
                    await MainActor.run {
                        self.coverImageData = data
                        self.coverImage = image
                        self.logger.info("A new image was setted with success.")
                    }
                }
            }
        }
    }
    
    init() { }
    
    init(coverImage: UIImage?, coverImageData: Data?) {
        self.coverImage = coverImage
        self.coverImageData = coverImageData
    }
}
