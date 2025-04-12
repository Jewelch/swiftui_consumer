//
//  DataSourceConfiguration.swift
//  SwiftUI_Consumer
//
//  Created by Jewel CHERIAA on 12/06/2023.
//

import Foundation

public typealias DataSourceConfiguration = TimeoutsConfiguration & BaseApiHostConfiguration & InjectablesConfiguration & RequestDebugging


// MARK: - BASE API HOST ---------------------------------------------------
public protocol RequestDebugging {
    var debugginEnabled: Bool { get }
}

public extension RequestDebugging {
    var debugginEnabled: Bool { return false }
} // -----------------------------------------------------------------------



// MARK: - TIMEOUTS --------------------------------------------------------
public protocol TimeoutsConfiguration {
    var requestTimeoutInterval: TimeInterval { get }
    var sessionTimeoutIntervalForRequest: TimeInterval { get }
    var sessionTimeoutIntervalForResource: TimeInterval { get }
}

public extension TimeoutsConfiguration {
    var requestTimeoutInterval: TimeInterval { return 60 }
    var sessionTimeoutIntervalForRequest: TimeInterval { return 60 }
    var sessionTimeoutIntervalForResource: TimeInterval { return 60 }
} // -----------------------------------------------------------------------

// MARK: - BASE API HOST ---------------------------------------------------
public protocol BaseApiHostConfiguration {
    var baseApiHost: String { get }
}

public extension BaseApiHostConfiguration {
    var baseApiHost: String { return "" }
} // -----------------------------------------------------------------------

// MARK: - INJECTABLES -----------------------------------------------------
public protocol InjectablesConfiguration {
    // Query Items
    var autoInjectableQueryItems: Params { get }

    // Body
    var autoInjectableBodyItems: Params { get }
    var defaultBodyEncoding: Body.DataEncoding { get }

    // Headers
    var autoInjectableHeaders: Params { get }
}

public extension InjectablesConfiguration {
    // Query Items
    var autoInjectableQueryItems: Params { return [:] }

    // Body
    var autoInjectableBodyItems: Params { return [:] }
    var defaultBodyEncoding: Body.DataEncoding { return .JSON }

    // Headers
    var autoInjectableHeaders: Params { return [:] }
} // -----------------------------------------------------------------------
