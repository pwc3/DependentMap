//
//  DependentDictionaryTests.swift
//  DependentMap
//
//  Copyright (c) 2019 Anodized Software, Inc.
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

    static var int: DependentMapKey<DependentDictionary, Int> {
        return .init("int")
    }

    static var float: DependentMapKey<DependentDictionary, Float> {
        return .init("float")
    }

    static var date: DependentMapKey<DependentDictionary, Date> {
        return .init("date")
    }

    static var string: DependentMapKey<DependentDictionary, String> {
        return .init("string")
    }
}

class DependentDictionaryTests: XCTestCase {

    private var d: DependentDictionary!

    override func setUp() {
        super.setUp()
        d = DependentDictionary()
    }

    func testInt() {
        XCTAssertNil(d[.int])
        d[.int] = 42
        XCTAssertEqual(d[.int], 42)

        d[.int] = nil
        XCTAssertNil(d[.int])
    }

    func testFloat() {
        XCTAssertNil(d[.float])
        d[.float] = 3.14159
        XCTAssertEqual(d[.float], 3.14159)

        d[.float] = nil
        XCTAssertNil(d[.float])
    }

    func testDate() {
        let date = Date()

        XCTAssertNil(d[.date])
        d[.date] = date
        XCTAssertEqual(d[.date], date)

        d[.date] = nil
        XCTAssertNil(d[.date])
    }

    func testString() {
        XCTAssertNil(d[.string])
        d[.string] = "foobar"
        XCTAssertEqual(d[.string], "foobar")

        d[.string] = nil
        XCTAssertNil(d[.string])
    }
}
