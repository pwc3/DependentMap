//
//  DictionaryTests.swift
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

    static var int: DependentMapKey<[UUID: Any], UUID, Int> {
        return .init(UUID(uuidString: "779CB7FE-38BF-4FC9-920C-F2321F699ED9")!)
    }

    static var float: DependentMapKey<[UUID: Any], UUID, Float> {
        return .init(UUID(uuidString: "1901A435-C13A-4768-96D4-696BC6C23209")!)
    }

    static var date: DependentMapKey<[UUID: Any], UUID, Date> {
        return .init(UUID(uuidString: "24D899E6-6FBB-4BE2-90B4-6026565589CD")!)
    }

    static var string: DependentMapKey<[UUID: Any], UUID, String> {
        return .init(UUID(uuidString: "2D02A729-BE86-4697-B244-DCD44DC215A1")!)
    }
}

class DictionaryTests: XCTestCase {

    private var d: [UUID: Any] = [:]

    override func setUp() {
        super.setUp()
        d = [:]
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
