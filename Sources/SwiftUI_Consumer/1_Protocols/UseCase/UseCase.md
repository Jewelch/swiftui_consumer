# Understanding @unchecked Sendable in UseCase

## What is Sendable?

`Sendable` is a protocol in Swift that marks types that can be safely transferred across concurrency boundaries (between actors, tasks, or threads) without creating data races.

When you send data across these boundaries, Swift wants to ensure you're not creating opportunities for concurrent access to mutable state, which can lead to data races and hard-to-debug issues.

## What does @unchecked Sendable mean?

`@unchecked Sendable` is a special conformance that tells the compiler:

1. "This type will be Sendable"
2. "But the compiler can't verify this automatically, so I (the developer) take responsibility for ensuring thread safety"

It's like saying "trust me, I've made this class safe for concurrent use" when the compiler can't prove it automatically.

## Why is it needed for UseCase?

Your `UseCase` class couldn't be automatically verified as `Sendable` because:

1. It has a closure property (`dataSourceFetcher`) that captures and could potentially reference non-sendable types
2. It's a class (reference type), which by default isn't Sendable unless proven to be thread-safe
3. It deals with generic parameters where the thread safety would depend on the actual types used

## Why did the warning appear initially?

The warning appeared because:

1. You were passing a `UseCase` instance across concurrency boundaries (likely between actors or tasks)
2. Swift couldn't verify it was safe to do so without the `Sendable` conformance
3. In Swift 6, this will become an error rather than just a warning

## Why do subclasses need to restate it?

When a subclass inherits from an `@unchecked Sendable` type, it must explicitly restate this conformance. This is intentional:

1. It forces developers to consciously acknowledge they're taking on the responsibility for thread safety
2. It prevents accidentally inheriting the behavior without realizing the implications
3. It reminds developers that any additional state they add must also be thread-safe

## Best Practices

1. **Use value types when possible**: Structs and enums are easier to make Sendable
2. **Immutable data**: The less mutable state, the fewer concurrency problems
3. **Actor isolation**: Use actors to protect mutable state
4. **Careful use of @unchecked**: Only use when you're sure the type is thread-safe but the compiler can't verify it

## Implementation Notes

When implementing UseCase subclasses, always add the `@unchecked Sendable` conformance explicitly:

```swift
final class MyUseCase: UseCase<MyModel, MyEntity>, @unchecked Sendable {
    // Implementation...
}
```

The `UseCase` class design with its closure-based approach is easier to work with using `@unchecked Sendable`, but it does place responsibility on you to ensure thread safety in all implementations.

## Further Reading

- [Swift Concurrency Documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)
- [SE-0302: Sendable and @Sendable closures](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0302-concurrent-value-and-concurrent-closures.md) 