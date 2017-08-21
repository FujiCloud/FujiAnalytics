//
//  FujiUserDefaultsKey.swift
//  Fuji
//
//  Created by Jack Cook on 8/20/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

enum FujiUserDefaultsKey: String {
    case defaultsConfigured
    case queuedRequests
    
    var value: String {
        return "Fuji-\(rawValue)"
    }
}
