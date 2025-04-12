//
//  DataSource+Publisher.swift
//  SwiftUI_Consumer
//
//  Created by Jewel Cheriaa on 10/03/2025.
//

import Combine
import Foundation
import SwiftUI_Infrastructure

public extension DataSource {
    func publisherCall(
        method: RestfulMethods? = nil,
        urlComponents: URLComposer? = nil,
        headers: Params? = nil,
        body: Body? = nil,
        decodingStrategies: JSONDecodingStrategies = .init(),
        debugIt: Bool = false
    ) -> DataSourceResult<M> {
        return (urlComponents ?? self.urlComponents ?? .init(path: ""))
            .toURLRequest(method: method ?? self.method ?? .post)
            .setupHeaders(headers ?? self.headers)
            .setupBody(body ?? self.body)
            .launchURLSession()
            .serializeAndPrintJSONWhen(debugIt)
            .decode(using: M.self, following: decodingStrategies)
    }
}
