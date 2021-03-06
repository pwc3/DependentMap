//
//  Dictionary+DependentMapSemantics.swift
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

/// Adds dependent map semantics to the `Dictionary` type. Note that the extension is only applicable when the dictionary's value type is `Any`.
extension Dictionary: DependentMapSemantics
    where Value: Any
{
    public typealias RawKeyType = Key

    public func value<DependentKeyType, ValueType>(for key: DependentKeyType) -> ValueType?
        where DependentKeyType : DependentMapKey<Dictionary, RawKeyType, ValueType>
    {
        return self[key.rawValue] as? ValueType
    }

    public mutating func set<DependentKeyType, ValueType>(_ value: ValueType?, for key: DependentKeyType)
        where DependentKeyType : DependentMapKey<Dictionary, RawKeyType, ValueType>
    {
        self[key.rawValue] = value as? Value
    }
}
