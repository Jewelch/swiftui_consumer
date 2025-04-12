//
//  UseCase.swift
//  SwiftUI_Consumer
//
//  Created by Jewel Cheriaa on 07/03/2025.
//

import Combine
import Foundation
import SwiftUI_Infrastructure

open class UseCase<M: Model, E: Entity>: @unchecked Sendable where E.M == M {
    private let dataSourceFetcher: @Sendable (Any?) -> DataSourceResult<M>

    public init(_ dataSourceFetcher: @escaping @Sendable (Any?) -> DataSourceResult<M>) {
        self.dataSourceFetcher = dataSourceFetcher
    }

    public func publisherCall(_ params: Any? = nil) -> UseCaseResult<E> {
        dataSourceFetcher(params)
            .map { E.fromModel($0) }
            .eraseToAnyPublisher()
    }

    public func asyncCall(_ params: Any? = nil) async throws -> E? {
        try await publisherCall(params).async()
    }
}

