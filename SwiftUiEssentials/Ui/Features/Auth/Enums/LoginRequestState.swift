//
//  LoginRequestState.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

// MARK: - LoginRequestState
enum LoginRequestState {
    case idle
    case loggingIn
    case success(LoginResponse)
    case failure(String)
}
