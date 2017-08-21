//
//  FujiSession.swift
//  Fuji
//
//  Created by Jack Cook on 8/20/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// A session of usage of the app.
public struct FujiSession {
    
    /// The id of this session.
    let id: Int?
    
    /// The id of the user that this session belongs to.
    let userId: Int
    
    /// The duration of this session, in seconds.
    let duration: Int?
    
    /// The timestamp at which this session began.
    let createdAt: Date
    
    /// Starts a session.
    public init() {
        id = nil
        userId = 1
        duration = nil
        createdAt = Date()
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
