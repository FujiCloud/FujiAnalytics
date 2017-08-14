//
//  FujiRequest.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

protocol FujiRequest {
    associatedtype Value
    
    var body: Any? { get }
    var endpoint: String { get }
    var method: String { get }
    
    func handleRequest(_ data: Any?, _ completion: @escaping (Value?) -> Void)
}

extension FujiRequest {
    
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
