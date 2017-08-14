//
//  EventRequest.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

class EventRequest: FujiRequest {
    
    typealias Value = Bool
    
    var body: Any? {
        return event.dictionaryRepresentation
    }
    
    var endpoint: String {
        return "/events"
    }
    
    var method: String {
        return "POST"
    }
    
    private let event: FujiEvent
    
    init(event: FujiEvent) {
        self.event = event
    }
    
    func handleRequest(_ data: Any?, _ completion: @escaping (Bool?) -> Void) {
        guard let _ = data as? [String: Any] else {
            completion(false)
            return
        }
        
        completion(true)
    }
}
