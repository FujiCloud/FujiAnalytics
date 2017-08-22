//
//  UserRequest.swift
//  Fuji
//
//  Created by Jack Cook on 8/22/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

/// Sends details about a user to Fuji.
class UserRequest: FujiRequest {
    
    // MARK: - Request Configuration
    
    typealias Value = FujiUser
    
    var body: Any? {
        return user.dictionaryRepresentation
    }
    
    var endpoint = "/users"
    var method = "POST"
    
    // MARK: - Properties
    
    private let user: FujiUser
    
    // MARK: - Initialization
    
    init() {
        self.user = FujiUser()
    }
    
    init(user: FujiUser) {
        self.user = user
    }
    
    // MARK: - Request Handling
    
    func handleRequest(_ data: Any?, _ completion: ((FujiUser?) -> Void)?) {
        guard let data = data as? [String: Any] else {
            completion?(nil)
            return
        }
        
        do {
            completion?(try FujiUser(data: data))
        } catch {
            completion?(nil)
        }
    }
}
