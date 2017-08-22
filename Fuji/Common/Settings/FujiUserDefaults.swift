//
//  FujiUserDefaults.swift
//  Fuji
//
//  Created by Jack Cook on 8/20/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import Foundation

class FujiUserDefaults: UserDefaults {
    
    static func setDefaultValues() {
        set(true, forKey: .defaultsConfigured)
        set([Any](), forKey: .queuedRequests)
    }
    
    static func array(forKey defaultName: FujiUserDefaultsKey) -> [Any]? {
        return standard.array(forKey: defaultName.value)
    }
    
    static func bool(forKey defaultName: FujiUserDefaultsKey) -> Bool {
        return standard.bool(forKey: defaultName.value)
    }
    
    static func savedRequestsArray(forKey defaultName: FujiUserDefaultsKey) -> [SavedFujiRequest]? {
        return standard.array(forKey: defaultName.value)?.flatMap { data in
            guard let data = data as? [String: Any] else {
                return nil
            }
            
            return try? SavedFujiRequest(data: data)
        }
    }
    
    static func session(forKey defaultName: FujiUserDefaultsKey) -> FujiSession? {
        guard let data = standard.object(forKey: defaultName.value) as? [String: Any] else {
            return nil
        }
        
        return try? FujiSession(data: data)
    }
    
    static func user(forKey defaultName: FujiUserDefaultsKey) -> FujiUser? {
        guard let data = standard.object(forKey: defaultName.value) as? [String: Any] else {
            return nil
        }
        
        return try? FujiUser(data: data)
    }
    
    static func removeObject(forKey defaultName: FujiUserDefaultsKey) {
        standard.removeObject(forKey: defaultName.value)
    }
    
    static func append(_ value: Any, toArray defaultName: FujiUserDefaultsKey) {
        var array = self.array(forKey: .queuedRequests)
        array?.append(value)
        standard.set(array, forKey: defaultName.value)
    }
    
    static func remove(at index: Int, fromArray defaultName: FujiUserDefaultsKey) {
        var array = self.array(forKey: .queuedRequests)
        array?.remove(at: index)
        standard.set(array, forKey: defaultName.value)
    }
    
    static func set(_ value: [Any], forKey defaultName: FujiUserDefaultsKey) {
        standard.set(value, forKey: defaultName.value)
    }
    
    static func set(_ value: Bool, forKey defaultName: FujiUserDefaultsKey) {
        standard.set(value, forKey: defaultName.value)
    }
    
    static func set(_ value: FujiSession, forKey defaultName: FujiUserDefaultsKey) {
        standard.set(value.dictionaryRepresentation, forKey: defaultName.value)
    }
    
    static func set(_ value: FujiUser, forKey defaultName: FujiUserDefaultsKey) {
        standard.set(value.dictionaryRepresentation, forKey: defaultName.value)
    }
}
