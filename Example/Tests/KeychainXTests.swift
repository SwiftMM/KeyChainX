//
//  KeychainXTests.swift
//  KeychainX_Tests
//
//  Created by Fakerlogic on 8/19/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import KeychainX

class KeychainXTests: XCTestCase {

    var keychainX: KeychainX!
    
    let stringValue = "fakerlogic"
    let stringKey = "testSetString.keychainx"
    let intValue = 11
    let intKey = "testSetInt.keychainx"
    let decimalValue = 3.14
    let decimalKey = "testReadDecimal.keychainx"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        keychainX = KeychainX(serviceName:"test.keychainx")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        keychainX.removeAllKeys()
    }

    func testSettingString() {
        keychainX.set(stringValue, forKey: stringValue)
    }

    func testReadString() {
        keychainX.set(stringValue, forKey: stringValue)
        let r = keychainX.string(forKey: stringValue)
        if r != stringValue {
            XCTFail("Fetch the wrong value of key: \(stringValue), expected: \(stringValue)")
        }
    }

    func testReadInvalidString() {
        let result = keychainX.string(forKey: stringKey)
        
        if result != nil {
            XCTFail("Fetch string value of key:\(stringKey) should be nil.")
        }
    }
    
    func testSetInt() {
        guard keychainX.set(intValue, forKey: intKey) else {
            XCTFail("Set value of: \(intValue) for key: \(intKey) failed.")
            return
        }
    }
    
    func testReadInt() {
        keychainX.set(intValue, forKey: intKey)
        let result = keychainX.object(of: Int.self, forKey: intKey)
        
        if result != intValue {
            XCTFail("Fetch the wrong int value of key:\(intKey).\n\(intValue) is expected.")
        }
    }
    
    func testReadInvalidInt() {
        let result = keychainX.object(of: Int.self, forKey: intKey)
        XCTAssertEqual(result, nil)
    }
    
    func testUpdateInt() {
        keychainX.set(intValue, forKey: intKey)
        keychainX.set(4, forKey: intKey)
        let four = keychainX.object(of: Int.self, forKey: intKey)
        
        XCTAssert(four == 4, "Update value of: \(4) for key: \(intKey) failed.")
    }
    
    func testSetDecimal() {
        guard keychainX.set(decimalValue, forKey: decimalKey) else {
            XCTFail("Set value of: \(decimalValue) for key: \(decimalKey) failed.")
            return
        }
    }
    
    func testReadDecimal() {
        keychainX.set(decimalValue, forKey: decimalKey)
        let result = keychainX.object(of: Double.self, forKey: decimalKey)
        
        if result != decimalValue {
            XCTFail("Fetch the wrong floating point number of key:\(decimalKey).\n\(decimalValue) is expected.")
        }
    }
    
}
