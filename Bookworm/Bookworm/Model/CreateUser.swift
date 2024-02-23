//
//  CreateUser.swift
//  Bookworm
//
//  Created by Isaque da Silva on 23/02/24.
//

import Foundation

struct CreateUser: Encodable {
    let name: String
    let username: String
    let email: String
    let password: String
    let confirmPassword: String
}
