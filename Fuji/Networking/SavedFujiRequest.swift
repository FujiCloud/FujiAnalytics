//
//  SavedFujiRequest.swift
//  Fuji
//
//  Created by Jack Cook on 8/20/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// Any request that was previously queued.
class SavedFujiRequest: FujiRequest {
    
    // MARK: - Request Configuration
    
    typealias Value = Bool
    
    var body: Any? {
        return requestBody
    }
    
    var endpoint: String {
        return requestEndpoint
    }
    
    var method: String {
        return requestMethod
    }
    
    // MARK: - Properties
    
    /// A unique id for this saved request that is only stored locally.
    let id: String
    
    /// The body of the request.
    let requestBody: Any?
    
    /// The endpoint that this request is supposed to hit.
    let requestEndpoint: String
    
    /// The method that this request is supposed to use.
    let requestMethod: String
    
    // MARK: - Initialization
    
    /// Initializes a saved request.
    ///
    /// - Parameter data: The data that represents this saved request.
    /// - Throws: Throws an error if the data is invalid.
    init(data: [String: Any]) throws {
        guard let id = data["id"] as? String, let endpoint = data["endpoint"] as? String, let method = data["method"] as? String else {
            throw FujiError.invalidArguments
        }
        
        self.id = id
        requestBody = data["body"]
        requestEndpoint = endpoint
        requestMethod = method
    }
    
    // MARK: - Request Handling
    
    func handleRequest(_ data: Any?, _ completion: ((Bool?) -> Void)?) {
        // Device is probably offline, retry later
        guard data != nil else {
            return
        }
        
        guard let queuedRequests = FujiUserDefaults.savedRequestsArray(forKey: .queuedRequests), let index = queuedRequests.index(where: { $0.id == self.id }) else {
            return
        }
        
        FujiUserDefaults.remove(at: index, fromArray: .queuedRequests)
    }
}
