//
//  DataSourceConfigurator.swift
//  SwiftUI_Consumer
//
//  Created by Jewel Cheriaa on 10/03/2025.
//

import Foundation

/// Protocol that allows an application to define its DataSourceConfiguration
/// This follows the same pattern as EnvironmentSelector to provide a cleaner, more consistent implementation
@MainActor
public protocol ConsumerConfigurator {
    /// The configuration to use for the DataSourceConfigurator
    static var config: DataSourceConfiguration { get set }
}

/// Default implementation
@MainActor
public extension ConsumerConfigurator {
    /// Configures the DataSourceConfigurator with the provided configuration
    static var config: DataSourceConfiguration {
        get {
            // Return nil by making it a computed property that accesses internal storage
            fatalError("config is write-only. Use this property to configure DataSourceConfigurator.")
        }
        set {
            DataSourceConfigurator.configure(with: newValue)
        }
    }
}

public enum DataSourceConfigurator {
    public nonisolated(unsafe) static var debugginEnabled: Bool = false
    public nonisolated(unsafe) static var requestTimeoutInterval: TimeInterval = 60
    public nonisolated(unsafe) static var sessionTimeoutIntervalForRequest: TimeInterval = 60
    public nonisolated(unsafe) static var sessionTimeoutIntervalForResource: TimeInterval = 60
    public nonisolated(unsafe) static var baseApiHost: String = ""
    public nonisolated(unsafe) static var autoInjectableQueryItems: Params = [:]
    public nonisolated(unsafe) static var autoInjectableBodyItems: Params = [:]
    public nonisolated(unsafe) static var defaultBodyEncoding: Body.DataEncoding = .JSON
    public nonisolated(unsafe) static var autoInjectableHeaders: Params = [:]

    public static func configure(with config: DataSourceConfiguration) {
        debugginEnabled = config.debugginEnabled
        requestTimeoutInterval = config.requestTimeoutInterval
        sessionTimeoutIntervalForRequest = config.sessionTimeoutIntervalForRequest
        sessionTimeoutIntervalForResource = config.sessionTimeoutIntervalForResource
        baseApiHost = config.baseApiHost
        autoInjectableQueryItems = config.autoInjectableQueryItems
        autoInjectableBodyItems = config.autoInjectableBodyItems
        defaultBodyEncoding = config.defaultBodyEncoding
        autoInjectableHeaders = config.autoInjectableHeaders
    }
}
