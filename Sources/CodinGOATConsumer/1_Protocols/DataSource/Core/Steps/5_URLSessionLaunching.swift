//
//  URLSessionLaunching.swift
//
//  Created by Jewel CHERIAA on 22/05/2023.
//

import Combine
import Foundation
import SwiftUI_Infrastructure

extension AnyPublisher where Output == URLRequest, Failure == Error {
    func launchURLSession() -> AnyPublisher<Data, Error> {
        let config = URLSessionConfiguration.default

        config.timeoutIntervalForRequest = DataSourceConfigurator.sessionTimeoutIntervalForRequest
        config.timeoutIntervalForResource = DataSourceConfigurator.sessionTimeoutIntervalForResource
        config.waitsForConnectivity = true

        return flatMap { urlRequest in
            URLSession(configuration: config).dataTaskPublisher(for: urlRequest)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw URLSessionErrors.invalidResponse(response.debugDescription)
                    }
                    guard (200 ... 299) ~= httpResponse.statusCode else {
                        throw URLSessionErrors.invalidStatusCode(httpResponse.statusCode)
                    }
                    return data
                }
        }.eraseToAnyPublisher()
    }
}

enum URLSessionErrors: ErrorConvertible {
    case invalidResponse(_ response: Sendable)
    case invalidStatusCode(_ statusCode: Int)

    var error: ReadableError {
        switch self {
        case let .invalidResponse(response):
            return .init(message: "Invalid response:\n \(response)")
        case let .invalidStatusCode(statusCode):
            return .init(message: "Invalid status code: \(statusCode)")
        }
    }
}
