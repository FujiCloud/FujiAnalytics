//
//  FujiRequest.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// Protocol that all requests must inherit from.
protocol FujiRequest {
    
    /// The type that the response data is expected to conform to.
    associatedtype Value
    
    /// The request body (should either be an array or a dictionary).
    var body: Any? { get }
    
    /// The endpoint of the request.
    var endpoint: String { get }
    
    /// The HTTP method of the request.
    var method: String { get }
    
    /// Takes the response data and parses it to return the expected request value.
    ///
    /// - Parameters:
    ///   - data: The response data, converted to either an array or dictionary
    ///   - completion: The completion block that was passed in the start method
    func handleRequest(_ data: Any?, _ completion: @escaping (Value?) -> Void)
}

extension FujiRequest {
    
    /// Begins to execute the request.
    ///
    /// - Parameter completion: Block that fires when the request finishes with the expected returned data.
    func start(completion: @escaping (Value?) -> Void) {
        guard let url = Fuji.shared.settings?.baseURL.appendingPathComponent(endpoint) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = self.method
        
        if let body = body, let data = try? JSONSerialization.data(withJSONObject: body) {
            request.httpBody = data
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data) else {
                self.handleRequest(nil, completion)
                return
            }
            
            self.handleRequest(json, completion)
        }
        
        task.resume()
    }
}
