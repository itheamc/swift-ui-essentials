//
//  TodoTable.swift
//  SwiftUiEssentials
//
//  Created by Amit on 21/09/2024.
//

import SQLite
import SwiftUI

typealias Expression<T> = SQLite.Expression<T>

class TodoTable {

    // Database connection instance
    //
    private let db: Connection?

    // Table definition
    //
    private let todos = Table("todos")

    // Columns
    //
    private let id = Expression<Int64>("id")
    private let title = Expression<String?>("title")
    private let body = Expression<String?>("body")
    private let createdAt = Expression<String?>("created_at")
    private let updatedAt = Expression<String?>("updated_at")

    // Private constructor to enforce singleton pattern
    //
    init(db: Connection?) {
        self.db = db
        createTableIfNeeded()
    }

    // Function to create the table if it doesn't exist
    //
    private func createTableIfNeeded() {
        guard let db = db else {
            print("Database connection not available.")
            return
        }

        do {
            try db.run(todos.create(ifNotExists: true) { table in
                table.column(id, primaryKey: .autoincrement)
                table.column(title)
                table.column(body)
                table.column(createdAt)
                table.column(updatedAt)
            })
            print("Table 'todos' created or already exists.")
        } catch {
            print("Failed to create table 'todos': \(error)")
        }
    }

    // Function to insert a new todo item
    //
    func insert(title: String?, body: String?) async -> Int64? {
        guard let db = db else {
            print("Database connection not available.")
            return nil
        }

        let insert = todos.insert(
            self.title <- title,
            self.body <- body,
            self.createdAt <- DateUtils.dateToString(),
            self.updatedAt <- DateUtils.dateToString()
        )

        do {
            let rowId = try db.run(insert)
            print("Inserted new todo with ID: \(rowId)")
            return rowId
        } catch {
            print("Failed to insert new todo: \(error)")
            return nil
        }
    }
    
    // Function to update a todo item
    //
    func update(id: Int64, newTitle: String?, newBody: String?) async -> Bool {
        guard let db = db else {
            print("Database connection not available.")
            return false
        }

        let todo = todos.filter(self.id == id)
        let update = todo.update(
            self.title <- newTitle,
            self.body <- newBody,
            self.updatedAt <- DateUtils.dateToString()
        )

        do {
            if try db.run(update) > 0 {
                print("Updated todo with ID: \(id)")
                return true
            } else {
                print("Todo with ID \(id) not found.")
                return false
            }
        } catch {
            print("Failed to update todo: \(error)")
            return false
        }
    }

    // Function to delete a todo item
    //
    func delete(id: Int64) async -> Bool {
        guard let db = db else {
            print("Database connection not available.")
            return false
        }

        let todo = todos.filter(self.id == id)
        do {
            if try db.run(todo.delete()) > 0 {
                print("Deleted todo with ID: \(id)")
                return true
            } else {
                print("Todo with ID \(id) not found.")
                return false
            }
        } catch {
            print("Failed to delete todo: \(error)")
            return false
        }
    }
    
    // Function to get all todos
    //
    func getAll() async -> [Row]? {
        guard let db = db else {
            print("Database connection not available.")
            return nil
        }

        do {
            return Array(try db.prepare(todos))
        } catch {
            print("Failed to fetch todos: \(error)")
            return nil
        }
    }


    // Function to insert a new todo item asynchronously
    //
    func insertAsync(title: String?, body: String?) async -> Int64? {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                guard let db = self.db else {
                    print("Database connection not available.")
                    continuation.resume(returning: nil)
                    return
                }

                let insert = self.todos.insert(
                    self.title <- title,
                    self.body <- body,
                    self.createdAt <- DateUtils.dateToString(),
                    self.updatedAt <- DateUtils.dateToString()
                )

                do {
                    let rowId = try db.run(insert)
                    print("Inserted new todo with ID: \(rowId)")
                    continuation.resume(returning: rowId)
                } catch {
                    print("Failed to insert new todo: \(error)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    // Function to get all todos asynchronously
    //
    func getAllAsync() async -> [Row]? {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                guard let db = self.db else {
                    print("Database connection not available.")
                    continuation.resume(returning: nil)
                    return
                }

                do {
                    let rows = Array(try db.prepare(self.todos))
                    continuation.resume(returning: rows)
                } catch {
                    print("Failed to fetch todos: \(error)")
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    // Function to update a todo item asynchronously
    func updateAsync(id: Int64, newTitle: String?, newBody: String?) async -> Bool {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                guard let db = self.db else {
                    print("Database connection not available.")
                    continuation.resume(returning: false)
                    return
                }

                let todo = self.todos.filter(self.id == id)
                let update = todo.update(
                    self.title <- newTitle,
                    self.body <- newBody,
                    self.updatedAt <- DateUtils.dateToString()
                )

                do {
                    if try db.run(update) > 0 {
                        print("Updated todo with ID: \(id)")
                        continuation.resume(returning: true)
                    } else {
                        print("Todo with ID \(id) not found.")
                        continuation.resume(returning: false)
                    }
                } catch {
                    print("Failed to update todo: \(error)")
                    continuation.resume(returning: false)
                }
            }
        }
    }

    // Function to delete a todo item asynchronously
    //
    func deleteAsync(id: Int64) async -> Bool {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                guard let db = self.db else {
                    print("Database connection not available.")
                    continuation.resume(returning: false)
                    return
                }

                let todo = self.todos.filter(self.id == id)
                do {
                    if try db.run(todo.delete()) > 0 {
                        print("Deleted todo with ID: \(id)")
                        continuation.resume(returning: true)
                    } else {
                        print("Todo with ID \(id) not found.")
                        continuation.resume(returning: false)
                    }
                } catch {
                    print("Failed to delete todo: \(error)")
                    continuation.resume(returning: false)
                }
            }
        }
    }


}
