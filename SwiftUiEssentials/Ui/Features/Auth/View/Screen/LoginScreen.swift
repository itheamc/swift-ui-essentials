//
//  LoginScreen.swift
//  SwiftUiEssentials
//
//  Created by Amit on 23/09/2024.
//

import SwiftUI

struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isVisible: Bool = false
    
    @ObservedObject var authViewModel: AuthViewModel = AuthViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Sign In")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                HStack {
                    if isVisible {
                        TextField("Password", text: $password)
                            .textContentType(.password)
                    } else {
                        SecureField("Password", text: $password)
                            .textContentType(.password)
                            .padding(.vertical, 0.5)
                    }
                                
                    Button(action: { isVisible.toggle() }) {
                        Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
                
                VStack {
                    Button(action: {
                        authViewModel.login(payload: LoginRequestPayload(email: email, password: password))
                    }) {
                        Text("Login")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green.gradient)
                            .cornerRadius(10)
                    }
                    .overlay {
                        if case .loggingIn = authViewModel.loginState {
                            ShimmerView()
                                .mask(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
            }
            
            
        }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue.gradient)
    }
}

#Preview {
    LoginScreen()
}
