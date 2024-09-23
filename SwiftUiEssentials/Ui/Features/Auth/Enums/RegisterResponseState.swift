//
//  RegisterResponseState.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

// MARK: - RegisterResponseState
enum RegisterResponseState {
    case idle
    case loggingIn
    case success(RegisterResponse)
    case failure(String)
}
