//
//  EntryFieldStyleProtocol.swift
//  Bookworm
//
//  Created by Isaque da Silva on 25/02/24.
//

import SwiftUI

protocol EntryFieldStyle {
    associatedtype Body: View
    
    func makeBody(_ configuration: EntryFieldStyleConfiguration) -> Body
}
