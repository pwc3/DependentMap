//
//  DependentMapSemantics.swift
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
 Defines dependent map semantics that can be applied to any type that provides map semantics from homogeneous keys to heterogeneous values.
 */
public protocol DependentMapSemantics {

    /// The homogeneous key type.
    associatedtype RawKeyType: Hashable

    /**
     Returns the value associated with the specified key. Will return `nil` if no value has been associated with the specified key or if the value associated with the specified key cannot be converted to the key's value type.

     The return type is defined by the `key` argument.
     */
    func value<DependentKeyType, ValueType>(for key: DependentKeyType) -> ValueType?
        where DependentKeyType: DependentMapKey<Self, RawKeyType, ValueType>

    /**
     Associates the specified value with the specified key.

     The type of the `value` argument must match the value type defined by the `key` argument.
     */
    mutating func set<DependentKeyType, ValueType>(_ value: ValueType?, for key: DependentKeyType)
        where DependentKeyType: DependentMapKey<Self, RawKeyType, ValueType>
}

extension DependentMapSemantics {

    /// Allows subscript notation to be used to read and write a key's associated value.
    public subscript<DependentKeyType, ValueType>(key: DependentKeyType) -> ValueType?
        where DependentKeyType: DependentMapKey<Self, RawKeyType, ValueType> {

        get {
            return value(for: key)
        }

        set {
            set(newValue, for: key)
        }
    }
}
