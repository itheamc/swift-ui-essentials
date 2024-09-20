//
//  NetworkRequestService.swift
//  SwiftUiEssentials
//
//  Created by Amit on 20/09/2024.
//

import Foundation

protocol NetworkRequestService {
    func get<T: Decodable>(
        endpoint: String,
        parameters: [String: String]?,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    )
    
    func post<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    )
    
    func put<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    )
    
    func patch<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    )
    
    func delete(
        endpoint: String,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<Bool, Error>) -> Void
    )
}
