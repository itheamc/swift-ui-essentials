//
//  UsersRepositoryImpl.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

final class UsersRepositoryImpl: UsersRepository {
    
    // Singleton Instance
    //
    static let shared = UsersRepositoryImpl()
    
    // Method to fetch the users
    //
    func fetchUsers<T: Decodable>(
        parameters: [String: String]? = nil,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        ApiNetworkRequestService.shared.get(
            endpoint: ApiEndpoint.users,
            parameters: parameters,
            initiated: initiated,
            completion: completion
        )
    }
        
}
