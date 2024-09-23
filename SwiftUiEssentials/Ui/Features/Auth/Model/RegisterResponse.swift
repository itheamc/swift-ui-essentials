//
//  RegisterResponse.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation


// MARK: - RegisterResponse
struct RegisterResponse: Codable {
    let message: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case message
        case success
    }
}
