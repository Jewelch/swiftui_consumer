# Updating Entity Protocol for Sendable Conformance

To properly support Swift's concurrency model, you should also update your `Entity` protocol definition in the SwiftUI_Infrastructure package.

Open this file:
```
/Users/jcheriaa/Desktop/ios_projects/swiftui_infrastructure/Sources/SwiftUI_Infrastructure/DTO/Entity.swift
```

And change the protocol definition from:
```swift
public protocol Entity: Equatable & Identifiable {
    associatedtype M: Model

    static func fromModel(_ model: M?) -> Self
}
```

To:
```swift
public protocol Entity: Equatable & Identifiable & Sendable {
    associatedtype M: Model

    static func fromModel(_ model: M?) -> Self
}
```

## Why This Is Necessary

1. Your `UseCaseResult` typealias returns entities across concurrency domains
2. Entities are used in async contexts and passed between concurrency boundaries
3. Making entities `Sendable` ensures they're thread-safe when used with Swift concurrency

## What This Means for Your Entities

All types conforming to `Entity` will need to be thread-safe. This usually means:

1. Value types (structs) are preferred, which is already common for DTOs
2. All properties should also be `Sendable`
3. The `fromModel` static method should not capture any non-Sendable values

Most of your existing entities should already satisfy these requirements since they're likely immutable value types used for presenting data in the UI.

## Complete Sendable Chain

By making both `Model` and `Entity` conform to `Sendable`, you establish a complete chain of thread-safety:

1. `Model` (Sendable) → `DataSourceResult` → async processing
2. `Entity` (Sendable) → `UseCaseResult` → async processing
3. `UseCase` (marked with `@unchecked Sendable`)

This ensures that data can safely flow through your clean architecture layers without risking data races, even when crossing concurrency boundaries. 