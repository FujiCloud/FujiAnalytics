//
//  FujiEventType.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// A type of event that can be sent on Fuji.
///
/// - contentView: A view on some type of content.
/// - custom: Allows you to define your own event with a custom name.
public enum FujiEventType {
    case contentView(page: String)
    case custom(name: String)
    
    /// The name of the event.
    var name: String {
        switch self {
        case .contentView:
            return "Content View"
        case .custom(let name):
            return name
        }
    }
}
