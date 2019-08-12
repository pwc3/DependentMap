//
//  UserDefaults+DependentMapSemantics.swift
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

import Foundation

/// Adds dependent map semantics to the `UserDefaults` type.
extension UserDefaults: DependentMapSemantics {

    public typealias RawKeyType = String

    public func value<DependentKeyType, ValueType>(for key: DependentKeyType) -> ValueType?
        where DependentKeyType: DependentMapKey<UserDefaults, RawKeyType, ValueType>
    {
        return value(forKey: key.rawValue) as? ValueType
    }

    public func set<DependentKeyType, ValueType>(_ value: ValueType?, for key: DependentKeyType)
        where DependentKeyType: DependentMapKey<UserDefaults, RawKeyType, ValueType>
    {
        set(value, forKey: key.rawValue)
    }
}

extension UserDefaults {

    /**
     Adds the specified key-value pair to the registration domain.

     See `UserDefaults.register(defaults:)` for further information.

     - parameter value: The default value for the specified key.
     - parameter key: The key.
     */
    public func register<DependentKeyType, ValueType>(defaultValue value: ValueType, for key: DependentKeyType)
        where DependentKeyType: DependentMapKey<UserDefaults, RawKeyType, ValueType>
    {
        register(defaults: [key.rawValue: value])
    }
}
