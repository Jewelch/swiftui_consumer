import Combine
import Foundation

public extension AnyPublisher {
    static func failure(_ error: Error) -> AnyPublisher<Output, Error> {
        Fail(error: error).eraseToAnyPublisher()
    }

    static func failure(_ message: String) -> AnyPublisher<Output, Error> {
        Fail(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: message])).eraseToAnyPublisher()
    }
}
