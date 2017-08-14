//
//  EventRequest.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

/// Sends an event to Fuji.
class EventRequest: FujiRequest {
    
    // MARK: - Request Configuration
    
    typealias Value = Bool
    
    var body: Any? {
        return event.dictionaryRepresentation
    }
    
    var endpoint = "/events"
    var method = "POST"
    
    // MARK: - Variables
    
    private let event: FujiEvent
    
    // MARK: - Initialization
    
    init(event: FujiEvent) {
        self.event = event
    }
    
    // MARK: - Request Handling
    
    func handleRequest(_ data: Any?, _ completion: @escaping (Bool?) -> Void) {
        guard let _ = data as? [String: Any] else {
            completion(false)
            return
        }
        
        completion(true)
    }
}
