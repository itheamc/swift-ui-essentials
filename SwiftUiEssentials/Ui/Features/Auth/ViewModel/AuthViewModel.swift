//
//  AuthViewModel.swift
//  SwiftUiEssentials
//
//  Created by Amit on 23/09/2024.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var loginState: LoginRequestState = .idle
    @Published var registerState: RegisterRequestState = .idle
    @Published var forgotPasswordState: ForgotPasswordRequestState = .idle
    
    // Method to handle login request
    //
    func login(payload: LoginRequestPayload) {
        AuthRepositoryImpl.shared.login(
            payload: payload,
            initiated: {
                self.loginState = .loggingIn
            },
            completion: { (result: Result<LoginResponse, Error>) in
                switch result {
                    case .success(let res):
                        self.loginState = .success(res)
                    case .failure(let error):
                        self.loginState = .failure(error.localizedDescription)
                }
            }
        )
    }
    
    
    // Method to handle register request
    //
    func register(payload: RegisterRequestPayload) {
        AuthRepositoryImpl.shared.register(
            payload: payload,
            initiated: {
                self.registerState = .registering
            },
            completion: { (result: Result<RegisterResponse, Error>) in
                switch result {
                    case .success(let res):
                        self.registerState = .success(res)
                    case .failure(let error):
                        self.registerState = .failure(error.localizedDescription)
                }
            }
        )
    }
    
    // Method to handle forgot password request
    //
    func forgotPassword(payload: ForgotPasswordRequestPayload) {
        AuthRepositoryImpl.shared.forgotPassword(
            payload: payload,
            initiated: {
                self.forgotPasswordState = .requesting
            },
            completion: { (result: Result<ForgotPasswordResponse, Error>) in
                switch result {
                    case .success(let res):
                        self.forgotPasswordState = .success(res)
                    case .failure(let error):
                        self.forgotPasswordState = .failure(error.localizedDescription)
                }
            }
        )
    }
}
