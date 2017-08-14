//
//  Fuji.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

public protocol FujiDelegate {
    func sentEvent(event: FujiEvent, successfully success: Bool)
}

public class Fuji {
    
    public static let shared = Fuji()
    
    public var delegate: FujiDelegate?
    
    var settings: FujiSettings?
    
    public func start() throws {
        settings = try FujiSettings.findSettingsFile()
    }
    
    public func send(event: FujiEvent) {
        EventRequest(event: event).start { success in
            self.delegate?.sentEvent(event: event, successfully: success ?? false)
        }
    }
}
