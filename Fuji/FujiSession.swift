//
//  FujiSession.swift
//  Fuji
//
//  Created by Jack Cook on 8/20/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// A session of usage of the app.
struct FujiSession {
    
    /// The id of this session.
    let id: Int?
    
    /// The id of the user that this session belongs to.
    let userId: Int
    
    /// The duration of this session, in seconds.
    let duration: Int?
    
    /// The timestamp at which this session began.
    let createdAt: Date
    
    /// Starts a session.
    init() {
        id = nil
        userId = 1
        duration = nil
        createdAt = Date()
    }
    
    /// Creates a session object.
    ///
    /// - Parameter data: A dictionary that represents this session.
    /// - Throws: Throws an error if the data dictionary doesn't have the correct keys.
    init(data: [String: Any]) throws {
        guard let id = data["id"] as? Int, let userId = data["user_id"] as? Int, let createdAtString = data["created_at"] as? String else {
            throw FujiError.invalidArguments
        }
        
        self.id = id
        self.userId = userId
        self.duration = data["duration"] as? Int
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        guard let createdAt = formatter.date(from: createdAtString) else {
            throw FujiError.invalidArguments
        }
        
        self.createdAt = createdAt
    }
    
    /// A dictionary representation of this session.
    var dictionaryRepresentation: [String: Any] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        var data: [String: Any] = ["user_id": userId, "created_at": formatter.string(from: createdAt)]
        
        if let id = id {
            data["id"] = id
        }
        
        if let duration = duration {
            data["duration"] = duration
        }
        
        return data
    }
}
