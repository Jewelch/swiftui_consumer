//
//  File.swift
//
//  Created by Jewel CHERIAA on 14/06/2023.
//

import Foundation

public extension URLRequest {
    mutating func setHeader<Keys: RawRepresentable, Values: RawRepresentable>(key: Keys, value: Values, valueParameter: String? = nil)
        where Keys.RawValue: StringProtocol, Values.RawValue: StringProtocol {
        setValue(value.rawValue.appending(valueParameter ?? ""), forHTTPHeaderField: key.rawValue as! String)
    }
}
