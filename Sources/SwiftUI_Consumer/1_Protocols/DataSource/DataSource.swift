//
//  DataSource.swift
//  SwiftUI_Consumer
//
//  Created by Jewel CHERIAA on 13/06/2023.
//

import Combine
import Foundation
import SwiftUI_Infrastructure

public protocol DataSource {
    associatedtype M: Model

    var method: RestfulMethods? { get }
    var urlComponents: URLComposer? { get }
    var headers: Params? { get }
    var body: Body? { get }
    var decodingStrategies: JSONDecodingStrategies { get }
    var debugIt: Bool { get }
}

public extension DataSource {
    var method: RestfulMethods? { return nil }
    var urlComponents: URLComposer? { return nil }
    var headers: Params? { return nil }
    var body: Body? { return nil }
    var decodingStrategies: JSONDecodingStrategies { return .init() }
    var debugIt: Bool { return true }
}

