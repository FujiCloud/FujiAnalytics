//
//  FujiUser.swift
//  Fuji
//
//  Created by Jack Cook on 8/22/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

/// A "user" represents one device for as long as the app is installed.
struct FujiUser {
    
    /// The current user, if there is one.
    static var current: FujiUser? {
        get {
            return FujiUserDefaults.user(forKey: .currentUser)
        }
        
        set {
            if let user = newValue {
                FujiUserDefaults.set(user, forKey: .currentUser)
            } else {
                FujiUserDefaults.removeObject(forKey: .currentUser)
            }
        }
    }
    
    /// The id of this user.
    let id: Int?
    
    /// The user's OS.
    let os: String
    
    /// The user's device.
    let device: String
    
    /// The user's locale.
    let locale: String?
    
    /// True if the user has voiceover enabled.
    let voiceover: Bool
    
    /// True if the user has bold text enabled.
    let boldText: Bool
    
    /// True if the user has reduce motion enabled.
    let reduceMotion: Bool
    
    /// True if the user has reduce transparency enabled.
    let reduceTransparency: Bool
    
    /// The timestamp at which this user was created.
    let createdAt: Date
    
    /// Creates this user.
    init() {
        id = nil
        os = "iOS \(UIDevice.current.systemVersion)"
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        device = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        locale = Locale(identifier: "en").localizedString(forIdentifier: Locale.current.identifier)
        
        voiceover = UIAccessibilityIsVoiceOverRunning()
        boldText = UIAccessibilityIsBoldTextEnabled()
        reduceMotion = UIAccessibilityIsReduceMotionEnabled()
        reduceTransparency = UIAccessibilityIsReduceTransparencyEnabled()
        
        createdAt = Date()
    }
    
    /// Creates a user object.
    ///
    /// - Parameter data: A dictionary that represents this user.
    /// - Throws: Throws an error if the data dictionary doesn't have the correct keys.
    init(data: [String: Any]) throws {
        guard let id = data["id"] as? Int, let os = data["os"] as? String, let device = data["device"] as? String, let voiceover = data["voiceover"] as? Bool, let boldText = data["bold_text"] as? Bool, let reduceMotion = data["reduce_motion"] as? Bool, let reduceTransparency = data["reduce_transparency"] as? Bool, let createdAtString = data["created_at"] as? String else {
            throw FujiError.invalidArguments
        }
        
        self.id = id
        self.os = os
        self.device = device
        self.locale = data["locale"] as? String
        self.voiceover = voiceover
        self.boldText = boldText
        self.reduceMotion = reduceMotion
        self.reduceTransparency = reduceTransparency
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let createdAt = formatter.date(from: createdAtString) else {
            throw FujiError.invalidArguments
        }
        
        self.createdAt = createdAt
    }
    
    /// A dictionary representation of this user.
    var dictionaryRepresentation: [String: Any] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        var data: [String: Any] = [
            "id": id,
            "os": os,
            "device": device,
            "voiceover": voiceover,
            "bold_text": boldText,
            "reduce_motion": reduceMotion,
            "reduce_transparency": reduceTransparency,
            "created_at": formatter.string(from: createdAt)
        ]
        
        if let id = id {
            data["id"] = id
        }
        
        if let locale = locale {
            data["locale"] = locale
        }
        
        return data
    }
    
    // MARK: - Static Methods
    
    static func createNewUser(completion: ((FujiUser?) -> Void)? = nil) {
        UserRequest().start { user in
            guard let user = user else {
                completion?(nil)
                return
            }
            
            FujiUser.current = user
            Fuji.shared.update(user: user)
        }
    }
}
