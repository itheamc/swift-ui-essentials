//
//  AuthRepository.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

public protocol AuthRepository {

    func login<LoginResponse: Decodable>(
        payloads: [String: String]?,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    )
    
    func register<RegisterResponse: Decodable>(
        payloads: [String: String]?,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<RegisterResponse, Error>) -> Void
    )
    
    func forgotPassword<ForgotPasswordResponse: Decodable>(
        payloads: [String: String]?,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<ForgotPasswordResponse, Error>) -> Void
    )

}
