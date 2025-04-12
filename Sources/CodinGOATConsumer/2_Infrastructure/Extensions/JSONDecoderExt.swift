//
//  JSONDecoderExt.swift
//
//  Created by Jewel CHERIAA on 14/06/2023.
//

import Combine
import Foundation

public extension JSONDecoder {
    func followingStrategies(_ strategies: JSONDecodingStrategies) -> JSONDecoder {
        keyDecodingStrategy = strategies.keyDecoding
        dataDecodingStrategy = strategies.dataDecoding
        dateDecodingStrategy = strategies.dateDecoding
        nonConformingFloatDecodingStrategy = strategies.nonConformingFloatDecoding
        return self
    }
}

public struct JSONDecodingStrategies {
    public var keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    public var dataDecoding: JSONDecoder.DataDecodingStrategy = .base64
    public var dateDecoding: JSONDecoder.DateDecodingStrategy = .millisecondsSince1970
    public var nonConformingFloatDecoding: JSONDecoder.NonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "Infinity", negativeInfinity: "-Infinity", nan: "NaN")

    public init(keyDecoding: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
                dataDecoding: JSONDecoder.DataDecodingStrategy = .base64,
                dateDecoding: JSONDecoder.DateDecodingStrategy = .millisecondsSince1970,
                nonConformingFloatDecoding: JSONDecoder.NonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "Infinity", negativeInfinity: "-Infinity", nan: "NaN")) {
        self.keyDecoding = keyDecoding
        self.dataDecoding = dataDecoding
        self.dateDecoding = dateDecoding
        self.nonConformingFloatDecoding = nonConformingFloatDecoding
    }
}
