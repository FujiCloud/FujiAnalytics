//
//  FujiEvent.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

public enum FujiEventType {
    case contentView(page: String)
    case custom(name: String)
    
    var name: String {
        switch self {
        case .contentView:
            return "Content View"
        case .custom(let name):
            return name
        }
    }
}

public struct FujiEvent {
    
    let attributes: [String: Any]
    let type: FujiEventType
    
    public init(type: FujiEventType, attributes: [String: Any] = [String: Any]()) {
        self.type = type
        self.attributes = attributes
    }
    
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
