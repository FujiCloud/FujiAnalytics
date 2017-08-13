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
        case .custom:
            return "Custom"
        }
    }
}

public struct FujiEvent {
    
    let type: FujiEventType
    
    public init(type: FujiEventType) {
        self.type = type
    }
    
    var dictionaryRepresentation: [String: Any] {
        var data: [String: Any] = ["name": type.name]
        
        switch type {
        case .contentView(let page):
            data["attributes"] = ["page": page]
        case .custom(let name):
            data["attributes"] = ["name": name]
        }
        
        return data
    }
}
