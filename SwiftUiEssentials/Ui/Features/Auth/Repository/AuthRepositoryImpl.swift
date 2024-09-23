//
//  AuthRepositoryImpl.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    
    // Singleton
    static let shared = AuthRepositoryImpl()
    
    // Method to login
    //
    func login<LoginResponse: Decodable>(
        payload: LoginRequestPayload,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    ) {
        ApiNetworkRequestService.shared.post(
            endpoint: ApiEndpoint.login,
            body: payload,
            initiated: initiated,
            completion: completion
        )
    }
    
    // Method to register
    //
    func register<RegisterResponse: Decodable>(
        payload: RegisterRequestPayload,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<RegisterResponse, Error>) -> Void
    ) {
        ApiNetworkRequestService.shared.post(
            endpoint: ApiEndpoint.register,
            body: payload,
            initiated: initiated,
            completion: completion
        )
    }
    
    // Method to handle forget password
    //
    func forgotPassword<ForgotPasswordResponse: Decodable>(
        payload: ForgotPasswordRequestPayload,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<ForgotPasswordResponse, Error>) -> Void
    ) {
        ApiNetworkRequestService.shared.post(
            endpoint: ApiEndpoint.forgotPassword,
            body: payload,
            initiated: initiated,
            completion: completion
        )
    }
}
