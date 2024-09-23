//
//  ForgotPasswordResponse.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

// MARK: - ForgotPasswordResponse
struct ForgotPasswordResponse: Codable {
    let message: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case message
        case success
    }
}
