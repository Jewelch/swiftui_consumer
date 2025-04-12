//
//  EnvironmentSelector.swift
//
//
//  Created by Jewel Cheriaa on 06/07/2023.
//

import Foundation

public protocol EnvironmentSelector {
    static var environment: Environments { get }
}

public extension EnvironmentSelector {
    static var environment: Environments { return Environments.dev }
}

/// Represents different deployment and testing environments in the application
public enum Environments {
    /// Mock environment for unit tests and UI tests with mocked data
    case mock
    /// Local environment for development with local services
    case local
    /// Development environment for active development
    case dev
    /// Quality Assurance environment for testing
    case qa
    /// Staging environment with production-like data
    case staging
    /// Pre-production environment for final testing
    case preprod
    /// Production environment
    case prod
}
