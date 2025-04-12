//
//  DataSource+Async.swift
//  SwiftUI_Consumer
//
//  Created by Jewel Cheriaa on 10/03/2025.
//

import Combine
import Foundation

public extension DataSource {
    func asyncCall(
        method: RestfulMethods? = nil,
        urlComponents: URLComposer? = nil,
        headers: Params? = nil,
        body: Body? = nil,
        decodingStrategies: JSONDecodingStrategies = .init(),
        debugIt: Bool = false
    ) async throws -> M? {
        return try await publisherCall(
            method: method,
            urlComponents: urlComponents,
            headers: headers,
            body: body,
            decodingStrategies: decodingStrategies,
            debugIt: debugIt
        ).async()
    }
}

// Add Combine to async/await bridge
public extension AnyPublisher {
    func async() async throws -> Output {
        try await withCheckedThrowingContinuation { continuation in
            var cancellable: AnyCancellable?

            cancellable = first()
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case let .failure(error):
                        continuation.resume(throwing: error)
                    }
                    cancellable?.cancel()
                } receiveValue: { value in
                    continuation.resume(returning: value)
                }
        }
    }
}
