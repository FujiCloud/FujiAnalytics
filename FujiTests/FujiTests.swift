//
//  FujiTests.swift
//  FujiTests
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import XCTest
import Fuji

class FujiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        do {
            try Fuji.shared.start()
        } catch {
            XCTFail()
        }
    }
    
    func testEvent() {
        let event = FujiEvent(type: .contentView(name: "Home"))
        Fuji.shared.send(event: event)
    }
}
