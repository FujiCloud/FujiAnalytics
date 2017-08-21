//
//  SessionUpdateRequest.swift
//  Fuji
//
//  Created by Jack Cook on 8/20/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

/// Updates a session's duration.
class SessionUpdateRequest: FujiRequest {
    
    // MARK: - Request Configuration
    
    typealias Value = FujiSession
    
    var body: Any? {
        return ["id": id, "duration": duration]
    }
    
    var endpoint = "/sessions"
    var method = "PATCH"
    
    // MARK: - Properties
    
    private let id: Int
    private let duration: Int
    
    // MARK: - Initialization
    
    init(id: Int, duration: Int) {
        self.id = id
        self.duration = duration
    }
    
    // MARK: - Request Handling
    
    func handleRequest(_ data: Any?, _ completion: ((FujiSession?) -> Void)?) {
        guard let data = data as? [String: Any] else {
            completion?(nil)
            return
        }
        
        do {
            completion?(try FujiSession(data: data))
        } catch {
            completion?(nil)
        }
    }
}
