//
//  LoginError.swift
//  Bookworm
//
//  Created by Isaque da Silva on 27/01/24.
//

import Foundation

enum LoginError: Error {
    case noTokenAvailable
    case youAreNotLoggedIn
}