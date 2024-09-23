//
//  RegisterRequestPayload.swift
//  SwiftUiEssentials
//
//  Created by Amit on 23/09/2024.
//

import Foundation

public struct RegisterRequestPayload: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case password
    }
}
