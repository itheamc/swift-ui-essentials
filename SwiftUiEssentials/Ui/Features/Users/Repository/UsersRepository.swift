//
//  UsersRepository.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

protocol UsersRepository {
    func fetchUsers<T: Decodable>(
        parameters: [String: String]?,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    )
}
