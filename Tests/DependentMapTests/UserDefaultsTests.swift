//
//  UserDefaultsTests.swift
//  DependentMap
//
//  Copyright (c) 2019-2020 Anodized Software, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

import DependentMap
import XCTest

fileprivate extension DependentMapKey {

    static var int: DependentMapKey<UserDefaults, String, Int> {
        return .init("int")
    }

    static var float: DependentMapKey<UserDefaults, String, Float> {
        return .init("float")
    }

    static var date: DependentMapKey<UserDefaults, String, Date> {
        return .init("date")
    }

    static var string: DependentMapKey<UserDefaults, String, String> {
        return .init("string")
    }
}

class UserDefaultsTests: XCTestCase {

    private var defaults: UserDefaults!

    private let suiteName = "UserDefaultsTests"

    override func setUp() {
        super.setUp()

        UserDefaults().removePersistentDomain(forName: suiteName)
        defaults = UserDefaults(suiteName: suiteName)
        defaults.register(defaultValue: "fnord", for: .string)
    }

    func testInt() {
        XCTAssertNil(defaults[.int])
        defaults[.int] = 42
        XCTAssertEqual(defaults[.int], 42)

        defaults[.int] = nil
        XCTAssertNil(defaults[.int])
    }

    func testFloat() {
        XCTAssertNil(defaults[.float])
        defaults[.float] = 3.14159
        XCTAssertEqual(defaults[.float], 3.14159)

        defaults[.float] = nil
        XCTAssertNil(defaults[.float])
    }

    func testDate() {
        let date = Date()

        XCTAssertNil(defaults[.date])
        defaults[.date] = date
        XCTAssertEqual(defaults[.date], date)

        defaults[.date] = nil
        XCTAssertNil(defaults[.date])
    }

    func testString() {
        XCTAssertEqual("fnord", defaults[.string])
        defaults[.string] = "foobar"
        XCTAssertEqual(defaults[.string], "foobar")

        defaults[.string] = nil
        XCTAssertEqual("fnord", defaults[.string])
    }
}
