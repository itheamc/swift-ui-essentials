//
//  LoginResponse.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let token: String?
    let userId, profileId: Int?
    let email, username: String?

    enum CodingKeys: String, CodingKey {
        case token
        case userId
        case profileId
        case email, username
    }
}
