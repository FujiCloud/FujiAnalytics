//
//  Fuji.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

class Fuji {
    
    static let shared = Fuji()
    
    private var settings: FujiSettings?
    
    func start() throws {
        settings = try FujiSettings.findSettingsFile()
    }
}
