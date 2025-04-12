# Updating Model Protocol for Sendable Conformance

To properly support Swift's concurrency model and prevent the "Sending value risks causing data races" warning, you need to update your `Model` protocol definition in the SwiftUI_Infrastructure package.

Open this file:
```
/Users/jcheriaa/Desktop/ios_projects/swiftui_infrastructure/Sources/SwiftUI_Infrastructure/DAO/Model.swift
```

And change the protocol definition from:
```swift
public protocol Model: Codable {}
```

To:
```swift
public protocol Model: Codable & Sendable {}
```

## Why This Is Necessary

1. Your `DataSourceResult` typealias returns models across concurrency domains
2. The `async()` method you're using requires the value to be `Sendable`
3. Making the `Model` protocol inherit from `Sendable` ensures that all your model types are thread-safe by default

## What This Means for Your Models

All types conforming to `Model` will need to be thread-safe. This usually means:

1. Value types (structs) are preferred
2. If using classes, they should be immutable or manage their own thread safety
3. All properties should also be `Sendable`

Most of your existing models should already satisfy these requirements since they're likely immutable data transport objects. 