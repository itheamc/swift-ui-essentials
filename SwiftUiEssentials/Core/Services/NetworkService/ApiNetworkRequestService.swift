//
//  ApiNetworkRequestService.swift
//  SwiftUiEssentials
//
//  Created by Amit on 20/09/2024.
//

import Foundation

class ApiNetworkRequestService: NetworkRequestService {
    
    // Singleton instance
    static let shared = ApiNetworkRequestService(baseURL: ApiConfig.baseUrl)
    
    // Base URL property
    private let baseURL: String
    
    // Instance of URLSession
    private let session: URLSession
    
    // Custom URLCache
    private let cache: URLCache
    
    // Private initializer to prevent creating new instances
    private init(baseURL: String) {
        // Base Url
        self.baseURL = baseURL
        
        // Create a custom URLCache instance
        self.cache = URLCache(
            memoryCapacity: ApiConfig.cacheMemoryCapacity,
            diskCapacity: ApiConfig.cacheDiskCapacity,
            diskPath: ApiConfig.diskPath
        )
        
        // Create a custom URLSession configuration if needed
        let configuration = URLSessionConfiguration.default
        
        // Set the url cache and request cache policy
        configuration.requestCachePolicy = ApiConfig.cachePolicy
        configuration.urlCache = self.cache
        
        // Set the timeout for requests
        configuration.timeoutIntervalForRequest = ApiConfig.requestTimeout
        configuration.timeoutIntervalForResource = ApiConfig.responseTimeout
               
        // Initialize the URLSession with the custom configuration
        self.session = URLSession(configuration: configuration)
    }
    
    // MARK: - GET Request with Parameters
    func get<T: Decodable>(
        endpoint: String,
        parameters: [String: String]? = nil,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var finalURLString = baseURL + endpoint
        
        // Append parameters to the URL string if available
        if let parameters = parameters, var urlComponents = URLComponents(string: finalURLString) {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            finalURLString = urlComponents.url?.absoluteString ?? finalURLString
        }
        
        performRequest(urlString: finalURLString, method: "GET", body: NilEncodable(), initiated: initiated, completion: completion)
    }
    
    // MARK: - POST Request
    func post<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let urlString = baseURL + endpoint
        performRequest(urlString: urlString, method: "POST", body: body, initiated: initiated, completion: completion)
    }
    
    // MARK: - PUT Request
    func put<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let urlString = baseURL + endpoint
        performRequest(urlString: urlString, method: "PUT", body: body, initiated: initiated, completion: completion)
    }
    
    // MARK: - PATCH Request
    func patch<T: Decodable, U: Encodable>(
        endpoint: String,
        body: U,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let urlString = baseURL + endpoint
        performRequest(urlString: urlString, method: "PATCH", body: body, initiated: initiated, completion: completion)
    }
    
    // MARK: - DELETE Request
    func delete(
        endpoint: String,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        let urlString = baseURL + endpoint
        performRequest(urlString: urlString, method: "DELETE", body: NilEncodable(), initiated: initiated, completion: completion)
    }
    
    // MARK: - Helper Method for All Requests
    private func performRequest<T: Decodable, U: Encodable>(
        urlString: String,
        method: String,
        body: U,
        initiated: @escaping () -> Void,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        initiated()
        
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                let invalidURLError = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
                completion(.failure(invalidURLError))
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if !(body is NilEncodable) {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
        }
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    let noDataError = NSError(domain: "No Data", code: 0, userInfo: nil)
                    completion(.failure(noDataError))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


private struct NilEncodable: Encodable {}
