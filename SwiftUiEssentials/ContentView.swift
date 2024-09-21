//
//  ContentView.swift
//  SwiftUiEssentials
//
//  Created by Amit on 20/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Add Todo") {
                Task {
                    if let inserted = await DatabaseManager
                        .shared
                        .todos
                        .insertAsync(title: "New Todo", body: "New Todo Body") {
                        print("Todo inserted \(inserted)")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
