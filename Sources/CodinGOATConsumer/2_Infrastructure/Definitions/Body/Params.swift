//
//  Params.swift
//
//  Created by Jewel CHERIAA on 02/06/2023.
//

import Foundation

public typealias Params = [String: CustomStringConvertible]

public extension Params {
    func formattedAsUrlQueryItems() -> String {
        return map { key, value -> String in
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
            let encodedValue = value.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value.description
            return "\(encodedKey)=\(encodedValue)"
        }.joined(separator: "&")
    }
    
    func ifUniqueMerge(in dictionary: inout Params) {
        guard !isEmpty else { return }
        dictionary.merge(self) { _, new in new }
    }
}
