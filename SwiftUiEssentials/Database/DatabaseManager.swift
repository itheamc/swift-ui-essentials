//
//  DatabaseManager.swift
//  SwiftUiEssentials
//
//  Created by Amit on 21/09/2024.
//

import Foundation
import SQLite

class DatabaseManager {
    

    // Singleton instance
    static let shared = DatabaseManager()
    
    // Database file name
    private static let databaseFileName = "db.sqlite3"
    
    // Instance of URLSession
    private let database: Connection?
    
    // Tables
    let todos: TodoTable
    
    // Constructor
    private init () {
        self.database = DatabaseManager.createDatabaseConnection()
        self.todos = TodoTable(db: self.database)
    }
    
    // Create and return the database connection
    private static func createDatabaseConnection() -> Connection? {
        // Get the path to the app's Documents directory
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Append the database file name to the path
            let databasePath = documentsDirectory.appendingPathComponent(databaseFileName).path
            
            // Use this path to create a connection
            do {
                let db = try Connection(databasePath)
                return db
            } catch {
                print("Unable to connect to the database: \(error)")
                return nil
            }
        }
            
        return nil
    }
    
    
}
