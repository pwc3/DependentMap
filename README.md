# DependentMap

`DependentMap` is a Swift micro-framework that defines a collection that maps from a key to a value whose type is specified by the key.

In Swift, a `Dictionary<KeyType, ValueType>` is a collection that maps keys to values. It is homogeneous in that all keys are of the same type (here, `KeyType`) and all values are of the same type (here, `ValueType`).

Oftentimes there are types with map semantics where the keys are all of the same type but the values are of different types. For example, consider `UserDefaults`. It allows you to associate arbitrary values with `String` keys. It remains up to the caller to know the value type associated with the key.

```swift
UserDefaults.standard.set("Alice", forKey: "username")
UserDefaults.standard.set(Date(), forKey: "createDate")

let username = UserDefaults.standard.string(forKey: "username")
let createDate = UserDefaults.standard.object(forKey: "createDate") as? Date
```

Here, we have added a `String` value under the `username` key and a `Date` value under the `createDate` key. But the type of the associated values is defined entirely by convention. You need to know the type of the `username` and `createDate` values to be able to read them from `UserDefaults`. You also need to use the `as?` construct to convert the `Any` value returned by `UserDefaults.object(forKey:)` to the actual `Date` type that key refers to.

The value type is associated with the keys, but that type is implicit and unknown to the compiler.

Enter dependent maps. A dependent map is a collection that maps keys to values. It allows the keys to specify the type of value that can be associated with them.

In our example above, we would create two keys, `username` and `createDate` and specify that their associated values are of type `String` and `Date`, respectively.

```swift
extension DependentMapKey {

    static var username: DependentMapKey<UserDefaults, String> {
        return .init("username")
    }

    static var createDate: DependentMapKey<UserDefaults, Date> {
        return .init("createDate")
    }
}
```

In the declarations above, `username` is a `DependentMapKey` that can be used as a key on a `UserDefaults` instance which will be associated with a `String` value. The `createDate` key is also defined for the `UserDefaults` type but its associated values are of type `Date`.

We can then use these keys to write to and read from a `UserDefaults` object:

```swift
UserDefaults.standard.set("Alice", for: .username)
UserDefaults.standard.set(Date(), for: .createDate)

let username = UserDefaults.standard.value(for: .username)
let createDate = UserDefaults.standard.value(for: .createDate)
```

In the calls to `set(_:for:)`, the compiler ensures that the value's type matches the expected value type declared by the key. Similarly, the compiler is able to infer the types of the values read by `value(for:)` to match those declared by the keys.

## Details

The framework defines a `DependentMapSemantics` protocol that requires two functions: `value(for:)` and `set(_:for:)` to read and write values associated with a key. A protocol extension defines a subscript operator for simpler read-write access.

The framework also defines a `DependentMapKey<MapType, ValueType>` class. The `MapType` parameter defines the `DependentMapSemantics` type this key can be used on. The `ValueType` defines the value type that the key maps to.

A `DependentDictionary` struct is provided that provides dependent map semantics on a `Dictionary`.

Finally, an extension to `UserDefaults` is provided to implement the `DependentMapSemantics` protocol.

