//
//  FujiSettings.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// Holds settings for Fuji that were specified in the Fuji-Info.plist file.
class FujiSettings {
    
    /// The base URL for all requests to start from.
    let baseURL: URL
    
    /// The app's API key.
    let key: String
    
    /// Creates a Fuji settings object.
    ///
    /// - Parameter data: Data that the settings should be parsed from.
    /// - Throws: Throws an error if the Fuji-Info.plist file was invalid.
    init(data: [String: String]) throws {
        guard let urlString = data["Base URL"], let url = URL(string: urlString), let apiKey = data["API Key"] else {
            throw FujiError.invalidPlistFile
        }
        
        baseURL = url
        key = apiKey
    }
    
    /// Finds the Fuji-Info.plist file.
    ///
    /// - Returns: Fuji settings, found in and parsed from the plist file.
    /// - Throws: Throws an error if the Fuji-Info.plist file was invalid or couldn't be found.
    static func findSettingsFile() throws -> FujiSettings {
        var plistURL: URL?
        
        for bundle in Bundle.allBundles {
            if let url = bundle.url(forResource: "Fuji-Info", withExtension: "plist") {
                plistURL = url
                break
            }
        }
        
        guard let url = plistURL, let contents = NSDictionary(contentsOf: url) as? [String: String] else {
            throw FujiError.couldntFindPlist
        }
        
        return try FujiSettings(data: contents)
    }
}
