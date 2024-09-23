//
//  RegisterRequestState.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

// MARK: - RegisterRequestState
enum RegisterRequestState {
    case idle
    case registering
    case success(RegisterResponse)
    case failure(String)
}
