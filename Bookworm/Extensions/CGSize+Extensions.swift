//
//  CGSize+Extensions.swift
//  Bookworm
//
//  Created by Isaque da Silva on 1/2/25.
//

import SwiftUI

extension CGSize {
    func aspectToFit(_ size: CGSize) -> CGSize {
        let scaleX = size.width / self.width
        let scaleY = size.height / self.height
        
        let aspectRatio = min(scaleX, scaleY)
        
        let width = aspectRatio * self.width
        let height = aspectRatio * self.height
        
        return .init(width: width, height: height)
    }
    
    static var coverMiniature: CGSize {
        .init(width: 75, height: 100)
    }
    
    static var coverFullSize: CGSize {
        .init(width: 150, height: 200)
    }
}
