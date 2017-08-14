//
//  Fuji.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// The main Fuji class.
public class Fuji {
    
    /// Fuji singleton.
    public static let shared = Fuji()
    
    /// Fuji delegate, optionally can be set to receive feedback on Fuji actions.
    public var delegate: FujiDelegate?
    
    /// Fuji settings, which were found in the Fuji-Info.plist file.
    var settings: FujiSettings?
    
    /// Starts Fuji. Currently only finds settings, but will later also begin session reporting.
    ///
    /// - Throws: Throws an error if the Fuji-Info.plist file was invalid or if it couldn't be found.
    public func start() throws {
        settings = try FujiSettings.findSettingsFile()
    }
    
    /// Sends an event to Fuji.
    ///
    /// - Parameter event: The event that should be sent.
    public func send(event: FujiEvent) {
        EventRequest(event: event).start { success in
            self.delegate?.sentEvent(event: event, successfully: success ?? false)
        }
    }
}
