//
//  ForgotPasswordRequestState.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

// MARK: - ForgotPasswordRequestState
enum ForgotPasswordRequestState {
    case idle
    case loggingIn
    case success(ForgotPasswordResponse)
    case failure(String)
}
