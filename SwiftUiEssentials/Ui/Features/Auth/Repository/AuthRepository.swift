//
//  AuthRepository.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

public protocol AuthRepository {

    func login<LoginResponse: Decodable>(
        payload: LoginRequestPayload,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    )
    
    func register<RegisterResponse: Decodable>(
        payload: RegisterRequestPayload,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<RegisterResponse, Error>) -> Void
    )
    
    func forgotPassword<ForgotPasswordResponse: Decodable>(
        payload: ForgotPasswordRequestPayload,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<ForgotPasswordResponse, Error>) -> Void
    )

}
