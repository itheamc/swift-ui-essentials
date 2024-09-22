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
//                    let count = await DatabaseManager
//                        .shared
//                        .todos
//                        .countAsync()
//                    
//                    for i in (count + 1)...(count + 50) {
//                        let _ = await DatabaseManager
//                            .shared
//                            .todos
//                            .insertAsync(title: "New Todo \(i)", body: "New Todo \(i) // Body")
//                    }
//                    
//                    let count1 = await DatabaseManager
//                        .shared
//                        .todos
//                        .count()
//                    print("Todo count1 \(count1)")
                    
                    if let todos = await DatabaseManager
                        .shared
                        .todos
                        .getAllAsync() {
                        todos.forEach { print($0.title ?? "") }
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
