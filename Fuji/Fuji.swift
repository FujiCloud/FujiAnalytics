//
//  Fuji.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

public class Fuji {
    
    public static let shared = Fuji()
    
    var settings: FujiSettings?
    
    public func start() throws {
        settings = try FujiSettings.findSettingsFile()
    }
    
    public func send(event: FujiEvent) {
        EventRequest(event: event).start { success in
            print("Event sent successfully? \(success ?? false)")
        }
    }
}
