//
//  DataSerializing.swift
//
//  Created by Jewel CHERIAA on 27/05/2023.
//

import Combine
import Foundation

extension AnyPublisher where Output == Data, Failure == Error {
    func serializeAndPrintJSONWhen(_ debugIt: Bool) -> AnyPublisher<Data, Error> {
        guard debugIt || DataSourceConfigurator.debugginEnabled else { return eraseToAnyPublisher() }

        return tryMap { data in
            DispatchQueue.global().async {
                debugPrint("- Response ------------------------------------------------------------------------")
                debugPrint(String(data: data, encoding: .utf8).unsafelyUnwrapped)
                debugPrint("-----------------------------------------------------------------------------------")
            }
            return data
        }.eraseToAnyPublisher()
    }
}
