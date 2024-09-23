//
//  ViewModels.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import Foundation

enum UsersRequestState {
    case idle
    case requesting
    case success([User])
    case failure(String)
}

class UsersViewModel: ObservableObject {
    @Published var usersState: UsersRequestState = .idle
    
    
    // Method to fetch users
    //
    func fetchUsers() {
        UsersRepositoryImpl.shared.fetchUsers(
            initiated: {
                self.usersState = .requesting
            },
            completion: { (result: Result<[User], Error>) in
                switch result {
                    case .success(let users):
                        self.usersState = .success(users)
                    case .failure(let error):
                        self.usersState = .failure(error.localizedDescription)
                }
            }
        )
    }
}


