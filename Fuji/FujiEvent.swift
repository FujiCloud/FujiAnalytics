//
//  FujiEvent.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

public enum FujiEventType {
    case contentView(name: String)
    case custom(name: String)
    
    var name: String {
        switch self {
        case .contentView:
            return "Content View"
        case .custom:
            return "Custom"
        }
    }
    
    var id: String {
        switch self {
        case .contentView(let name):
            return name
        case .custom(let name):
            return name
        }
    }
}

public struct FujiEvent {
    
    let type: FujiEventType
    
    public init(type: FujiEventType) {
        self.type = type
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "type": [
                "name": type.name,
                "id": type.id
            ]
        ]
    }
}
