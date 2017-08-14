//
//  FujiError.swift
//  Fuji
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

/// Errors that can be thrown by Fuji.
///
/// - couldntFindPlist: The Fuji-Info.plist file could not be found.
/// - invalidPlistFile: The Fuji-Info.plist file is invalid.
public enum FujiError: Error {
    case couldntFindPlist
    case invalidPlistFile
}
