//
//  JSONDecoding.swift
//
//  Created by Jewel CHERIAA on 24/05/2023.
//

import Combine
import Foundation
import SwiftUI_Infrastructure

fileprivate let jsonDecoder = JSONDecoder()

extension AnyPublisher where Output == Data {
    struct JsonDecodingError: Error {}

    func decode<T: Model>(using _: T.Type = T.self, following strategies: JSONDecodingStrategies)
        -> AnyPublisher<T?, Error> {
        return tryMap { data in

            do {
                let model = try jsonDecoder.followingStrategies(strategies).decode(T?.self, from: data)
                return model!
            } catch let error {
                debugPrint(error)
                throw DecodingErrors.unableToDecodeWithProvidedModel
            }
        }
        .tryMap { Optional($0) }
        .eraseToAnyPublisher()
    }
}

// MARK: - Errors
enum DecodingErrors: ErrorConvertible {
    case unableToDecodeWithProvidedModel

    var error: ReadableError {
        switch self {
        default: return .init(message: "Unable to decode using the provided model")
        }
    }
}
