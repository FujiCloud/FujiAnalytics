//
//  FujiTests.swift
//  FujiTests
//
//  Created by Jack Cook on 8/13/17.
//  Copyright © 2017 Fuji. All rights reserved.
//

import XCTest
@testable import Fuji

class FujiTests: XCTestCase {
    
    /// Test starting Fuji
    func testStart() {
        do {
            try Fuji.shared.start()
        } catch {
            XCTFail()
        }
    }
}
