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
    
    // MARK: - Singleton
    
    /// Fuji singleton.
    public static let shared = Fuji()
    
    // MARK: - Properties
    
    /// Fuji delegate, optionally can be set to receive feedback on Fuji actions.
    public var delegate: FujiDelegate?
    
    /// Fuji settings, which were found in the Fuji-Info.plist file.
    var settings: FujiSettings?
    
    // MARK: - Public Methods
    
    /// Starts Fuji. Currently only finds settings, but will later also begin session reporting.
    ///
    /// - Throws: Throws an error if the Fuji-Info.plist file was invalid or if it couldn't be found.
    public func start() throws {
        settings = try FujiSettings.findSettingsFile()
        
        initializeDefaults()
        startSession()
        
        SavedFujiRequest.executeQueuedRequests()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground(_:)), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    /// Sends an event to Fuji.
    ///
    /// - Parameter event: The event that should be sent.
    public func send(event: FujiEvent) {
        EventRequest(event: event).start { success in
            self.delegate?.sentEvent(event: event, successfully: success ?? false)
        }
    }
    
    // MARK: - Private Methods
    
    private func initializeDefaults() {
        guard !FujiUserDefaults.bool(forKey: .defaultsConfigured) else {
            return
        }
        
        FujiUserDefaults.setDefaultValues()
    }
    
    private func startSession() {
        SessionRequest().start()
    }
    
    private func endSession() {
        SessionUpdateRequest(id: 1, duration: 1).queue()
    }
    
    // MARK: - Notifications
    
    @objc private func didEnterBackground(_ notification: Notification) {
        endSession()
    }
    
    @objc private func willEnterForeground(_ notification: Notification) {
        startSession()
    }
}
