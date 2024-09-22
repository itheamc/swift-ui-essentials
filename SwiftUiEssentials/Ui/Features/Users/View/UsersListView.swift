//
//  UsersListView.swift
//  SwiftUiEssentials
//
//  Created by Amit on 22/09/2024.
//

import SwiftUI

struct UsersListView: View {
    @StateObject private var viewModel = UsersViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                switch viewModel.usersState {
                            case .idle:
                                VStack {
                                    Text("Idle")
                                        .font(.headline)
                                }
                            case .requesting:
                                VStack {
                                    Text("Loading...")
                                        .font(.headline)
                                }
                            case .success(let users):
                                List(users) { user in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(user.name ?? "")
                                                .font(.headline)
                                            Text(user.email?.lowercased() ?? "")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            Text(user.address?.city ?? "")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                            
                                        }
                                    }
                                }
                                .refreshable {
                                    viewModel.fetchUsers()
                                }
                            case .failure(let string):
                                VStack {
                                    Text(string)
                                }
                                
                            }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    UsersListView()
}
