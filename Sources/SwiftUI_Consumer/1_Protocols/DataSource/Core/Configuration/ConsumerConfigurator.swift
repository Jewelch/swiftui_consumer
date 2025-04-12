//
//  ConsumerConfigurator.swift
//
//  Created by Jewel Cheriaa on 12/04/2025.
//

/// Protocol that allows an application to define its DataSourceConfiguration
/// This follows the same pattern as EnvironmentSelector to provide a cleaner, more consistent implementation
@MainActor
public protocol ConsumerConfigurator {
    /// The configuration to use for the DataSourceConfigurator
    static var consumerConfiguration: DataSourceConfiguration { get set }
}

/// Default implementation
@MainActor
public extension ConsumerConfigurator {
    /// Configures the DataSourceConfigurator with the provided configuration
    static var consumerConfiguration: DataSourceConfiguration {
        get {
            // Return nil by making it a computed property that accesses internal storage
            fatalError("config is write-only. Use this property to configure DataSourceConfigurator.")
        }
        set {
            DataSourceConfigurator.configure(with: newValue)
        }
    }
}
