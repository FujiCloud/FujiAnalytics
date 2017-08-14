//
//  FujiDelegate.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

/// The delegate that reports major events that occur in Fuji.
public protocol FujiDelegate {
    
    /// Fires when an event was sent to Fuji.
    ///
    /// - Parameters:
    ///   - event: The event that was sent.
    ///   - success: Whether or not the event was sent successfully.
    func sentEvent(event: FujiEvent, successfully success: Bool)
}
