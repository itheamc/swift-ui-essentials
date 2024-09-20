//
//  ApiConfig.swift
//  SwiftUiEssentials
//
//  Created by Amit on 20/09/2024.
//

import Foundation

struct ApiConfig {
    // The production base URL for the API endpoints.
    static let productionBaseUrl = "https://jsonplaceholder.typicode.com/"
    
    // The staging base URL for testing purposes.
    static let stagingBaseUrl = "https://66ebf2422b6cf2b89c5c8caf.mockapi.io/api/v2/"
    
    /// The memory capacity for the URL cache, in bytes.
    static let cacheMemoryCapacity = 16 * 1024 * 1024
    
    /// The disk capacity for the URL cache, in bytes.
    static let cacheDiskCapacity = 64 * 1024 * 1024
    
    /// The path for the disk cache.
    static let diskPath = "SwiftUiEssentials"
    
    /// The timeout interval for requests, in seconds.
    static let requestTimeout: TimeInterval = 30
    
    /// The timeout interval for responses, in seconds.
    static let responseTimeout: TimeInterval = 60
    
    /// The cache policy for URL requests.
    static let cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    
    /// Computed property to switch between base URLs.
    static var baseUrl: String {
        #if DEBUG
        return stagingBaseUrl
        #else
        return productionBaseUrl
        #endif
    }
}
