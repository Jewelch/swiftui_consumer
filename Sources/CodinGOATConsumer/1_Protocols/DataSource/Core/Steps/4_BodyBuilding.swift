//
//  BodyBuilding.swift
//
//  Created by Jewel CHERIAA on 22/05/2023.
//

import Combine
import Foundation
import SwiftUI_Infrastructure

extension Publisher where Output == URLRequest {
    func setupBody(_ body: Body?) -> AnyPublisher<URLRequest, Error> {
        return tryMap { urlRequest in
            var modifiedRequest = urlRequest

            guard modifiedRequest.httpMethod != RestfulMethods.get.rawValue else { return modifiedRequest }

            body?.params?.ifUniqueMerge(in: &DataSourceConfigurator.autoInjectableBodyItems)

            guard !DataSourceConfigurator.autoInjectableBodyItems.isEmpty else { return modifiedRequest }

            switch body?.encoding ?? DataSourceConfigurator.defaultBodyEncoding {
            case .UTF8:
                modifiedRequest.httpBody = DataSourceConfigurator.autoInjectableBodyItems.formattedAsUrlQueryItems().data(using: .utf8)
                modifiedRequest.setHeader(key: Headers.Keys.contentType, value: Headers.Values.formUrlEncoded)

            case .JSON:
                guard
                    JSONSerialization.isValidJSONObject(DataSourceConfigurator.autoInjectableBodyItems) else {
                    throw BodyCreationErrors.paramsAreInvalidJSONObject
                }

                modifiedRequest.httpBody = try? JSONSerialization.data(withJSONObject: DataSourceConfigurator.autoInjectableBodyItems)
                modifiedRequest.setHeader(key: Headers.Keys.contentType, value: Headers.Values.applicationJson)

            case .MULTIPART:
                let boundary = "Boundary-\(UUID().uuidString)"

                modifiedRequest.setHeader(key: Headers.Keys.contentType, value: Headers.Values.multipartFormData, valueParameter: boundary)
                let boundaryEnding = "--\(boundary)--".data(using: .utf8)!
                var allMultiparts: [Data] = []

                allMultiparts.append(DataSourceConfigurator.autoInjectableBodyItems.toHttpMultipartData(boundary: boundary))

                body?.files?.forEach({ file in
                    allMultiparts.append(file.toHttpMultipartData(boundary: boundary))
                })

                modifiedRequest.httpBody = allMultiparts.reduce(Data(), +) + boundaryEnding
            }
            return modifiedRequest
        }.eraseToAnyPublisher()
    }
}

// MARK: Errors

enum BodyCreationErrors: ErrorConvertible {
    case paramsAreInvalidJSONObject

    var error: ReadableError {
        switch self {
        case .paramsAreInvalidJSONObject:
            return .init(message: "Params are invalid JSON object")
        }
    }
}
