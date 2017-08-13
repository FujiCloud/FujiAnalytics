//
//  FujiSettings.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

class FujiSettings {
    
    let baseURL: URL
    let key: String
    
    init(data: [String: String]) throws {
        guard let urlString = data["Base URL"], let url = URL(string: urlString), let apiKey = data["API Key"] else {
            throw FujiError.invalidPlistFile
        }
        
        baseURL = url
        key = apiKey
    }
    
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
