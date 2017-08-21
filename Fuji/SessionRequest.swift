//
//  SessionRequest.swift
//  Fuji
//
//  Created by Jack Cook on 8/20/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

/// Sends details about a session to Fuji.
class SessionRequest: FujiRequest {
    
    // MARK: - Request Configuration
    
    typealias Value = Bool
    
    var body: Any? {
        return session.dictionaryRepresentation
    }
    
    var endpoint = "/sessions"
    var method = "POST"
    
    // MARK: - Properties
    
    private let session: FujiSession
    
    // MARK: - Initialization
    
    init() {
        self.session = FujiSession()
    }
    
    init(session: FujiSession) {
        self.session = session
    }
    
    // MARK: - Request Handling
    
    func handleRequest(_ data: Any?, _ completion: ((Bool?) -> Void)?) {
        guard let _ = data as? [String: Any] else {
            completion?(false)
            return
        }
        
        completion?(true)
    }
}
