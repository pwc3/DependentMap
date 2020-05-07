//
//  DependentMapKey.swift
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

import Foundation

/**
 Defines a key in a dependent map. This type is generic with respect to three type parameters:

 - `MapType` is the type of the map this key indexes. It must implement the `DependentMapSemantics` protocol.
 - `RawKeyType` is the type of the raw value of this key. It is used to index the underlying collection. It must implement the `Hashable` protocol.
 - `ValueType` is the type of the values in the map referenced by this key.

 It is intended that static keys are added to this type in an extension. For example:

 ```
 extension DependentMapKey {
     static var lastLoginDate: DependentMapKey<UserDefaults, String, Date> {
         return .init("lastLogin")
     }
 }
 ```

 Here, we define a `username` key. The three type parameters are interpreted as follows:

 1. `UserDefaults`: This is can only be used to index `UserDefaults` instances.
 2. `String`: The raw key type is `String` (here, `"lastLogin"`).
 3. `Date`: Values associated with this key must be `Date` instances.
 */
public final class DependentMapKey<MapType: DependentMapSemantics, RawKeyType: Hashable, ValueType> {

    public let rawValue: RawKeyType

    public init(_ rawValue: RawKeyType) {
        self.rawValue = rawValue
    }
}
