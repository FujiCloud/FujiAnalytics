//
//  FujiEvent.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// An event that can be sent to Fuji.
public struct FujiEvent {
    
    /// The attributes of this event.
    let attributes: [String: Any]
    
    /// The type of this event.
    let type: FujiEventType
    
    /// Creates an event.
    ///
    /// - Parameters:
    ///   - type: The type of event.
    ///   - attributes: Any custom attributes that you wish to send with this event.
    public init(type: FujiEventType, attributes: [String: Any] = [String: Any]()) {
        self.type = type
        self.attributes = attributes
    }
    
    /// A dictionary representation of this event.
    var dictionaryRepresentation: [String: Any] {
        var attributes = self.attributes
        
        switch type {
        case .contentView(let page):
            attributes["page"] = page
        default:
            break
        }
        
        return ["name": type.name, "attributes": attributes]
    }
}
