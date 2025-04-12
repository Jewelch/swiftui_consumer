//
//  URLStringCreation.swift
//
//  Created by Jewel CHERIAA on 01/06/2023.
//

import Combine
import Foundation
import SwiftUI_Infrastructure

extension URLComposer {
    func toURLRequest(method: RestfulMethods) -> AnyPublisher<URLRequest, Error> {
        guard let url = URL(string: endpoint) else {
            return URLRequestStringErrors.unableToCreateUrl(endpoint: endpoint).publishFailure()
        }

        if DataSourceConfigurator.debugginEnabled {
            debugPrint("🧬 \(endpoint)")
        }

        var urlRequest = URLRequest(url: url,
                                    cachePolicy: .useProtocolCachePolicy,
                                    timeoutInterval: DataSourceConfigurator.requestTimeoutInterval)

        urlRequest.httpMethod = method.rawValue

        return Just(urlRequest)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - Errors

enum URLRequestStringErrors: ErrorConvertible {
    case unableToCreateUrl(endpoint: String)

    var error: ReadableError {
        switch self {
        case let .unableToCreateUrl(endpoint):
            return .init(message: "Unable to create URL from string:\n\(endpoint)")
        }
    }
}
