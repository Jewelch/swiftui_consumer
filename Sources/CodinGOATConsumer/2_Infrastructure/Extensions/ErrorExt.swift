//
//  ErrorExt.swift
//
//  Created by Jewel CHERIAA on 29/05/2023.
//

import Combine
import Foundation

public extension Error {
    func publishFailure<T>() -> AnyPublisher<T, Error> {
        return Fail(error: self)
            .eraseToAnyPublisher()
    }
}
