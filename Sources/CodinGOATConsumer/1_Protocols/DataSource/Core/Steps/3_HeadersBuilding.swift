//
//  HeadersBuilding.swift
//
//  Created by Jewel CHERIAA on 01/06/2023.
//

import Combine
import Foundation


extension Publisher where Output == URLRequest {
    func setupHeaders(_ headers: Params?) -> AnyPublisher<URLRequest, Error> {
        tryMap { request in
            var modifiedRequest = request

            headers?.ifUniqueMerge(in: &DataSourceConfigurator.autoInjectableHeaders)
            DataSourceConfigurator.autoInjectableHeaders.forEach {
                modifiedRequest.setValue($1.description, forHTTPHeaderField: $0)
            }

            return modifiedRequest
        }
        .eraseToAnyPublisher()
    }
}

enum Headers {
    enum Keys: String {
        case contentType = "Content-Type"
    }

    enum Values: String {
        case formUrlEncoded = "application/x-www-form-urlencoded"
        case applicationJson = "application/json"
        case multipartFormData = "multipart/form-data; boundary="
    }
}
