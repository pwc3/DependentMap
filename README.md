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

    static var username: DependentMapKey<UserDefaults, String, String> {
        return .init("username")
    }

    static var createDate: DependentMapKey<UserDefaults, String, Date> {
        return .init("createDate")
    }
}
```

The `DependentMapKey` declarations are generic with respect to three type parameters:

1. The type of dependent map that this key indexes. In both instances above, this is `UserDefaults`, indicating that these keys can only be used on `UserDefaults` instances.
2. The raw key type. This is `String` because `UserDefaults` uses `String` values as keys. The type of the raw value passed to the `init` function in the body of the computed properties must match this type.
3. The type of values in the map referenced by this key. The `username` key refers to `String` values and the `createDate` key refers to `Date` values.

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

The framework also defines a `DependentMapKey<MapType, RawKeyType, ValueType>` class. The `MapType` parameter defines the `DependentMapSemantics` type this key can be used on. The `RawKeyType` parameter defines the key type in the underlying collection. The `ValueType` defines the value type that the key maps to.

An extension to `Dictionary` is provided to add dependent map semantics. Note use of this extension is limited to `Dictionary` instances with `Any` as the value type.

Finally, an extension to `UserDefaults` is provided to add dependent map semantics.

